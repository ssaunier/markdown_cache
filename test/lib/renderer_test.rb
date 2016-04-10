require 'test_helper'

module MarkdownCache
  class RendererTest < Minitest::Test
    def setup
      MarkdownCache.configure do |config|
        config.redis = {}
      end
      redis = MarkdownCache.configuration.redis
      keys = redis.keys "markdown:*"
      redis.del(*keys) unless keys.empty?
      @markdown = Renderer.new
    end

    def test_nil_string_content
      html = @markdown.render(nil)
      assert_equal html, ""
    end

    def test_redis_caching_logic
      redis_mock = Minitest::Mock.new
      MarkdownCache.configuration.instance_variable_set(:@redis, redis_mock)

      key = "markdown:829c3804401b0727f70f73d4415e162400cbe57b"
      dump = Marshal.dump("<p>dummy</p>\n")

      redis_mock.expect(:get, nil, [ key ])
      redis_mock.expect(:set, nil, [ key, dump ])
      redis_mock.expect(:expire, nil, [ key, 604800])
      @markdown.render("dummy")

      redis_mock.expect(:get, dump, [ key ])
      @markdown.render("dummy")

      assert redis_mock.verify
    end

    def test_renders_one_simple_line
      html = @markdown.render("**Hello** _world_")
      assert_equal html, "<p><strong>Hello</strong> <em>world</em></p>\n"
    end

    def test_inline_code_block
      html = @markdown.render("this is `code`")
      assert_equal html, "<p>this is <code class=\"highlighter-rouge\">code</code></p>\n"
    end

    def test_fenced_code_blocks
      html = @markdown.render <<-MARKDOWN
This is a paragraph:

```ruby
def some_ruby_method(some_array)
  return some_array[0] * some_array[1]
end
```

And another one
MARKDOWN
      assert_equal html, <<-HTML
<p>This is a paragraph:</p>

<div class=\"highlighter-rouge\"><pre class=\"highlight\"><code><span class=\"k\">def</span> <span class=\"nf\">some_ruby_method</span><span class=\"p\">(</span><span class=\"n\">some_array</span><span class=\"p\">)</span>
  <span class=\"k\">return</span> <span class=\"n\">some_array</span><span class=\"p\">[</span><span class=\"mi\">0</span><span class=\"p\">]</span> <span class=\"o\">*</span> <span class=\"n\">some_array</span><span class=\"p\">[</span><span class=\"mi\">1</span><span class=\"p\">]</span>
<span class=\"k\">end</span>
</code></pre>
</div>

<p>And another one</p>
HTML
    end
  end
end
