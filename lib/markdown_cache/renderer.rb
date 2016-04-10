require 'kramdown'
require 'digest/sha1'

module MarkdownCache
  class Renderer
    EXPIRE = 7 * 24 * 3600  # 7 days

    def render(text)
      return "" if text.nil?
      from_cache(key(Digest::SHA1.hexdigest(text))) do
        kramdown_render(text)
      end
    end

    private

    def kramdown_render(text)
      Kramdown::Document.new(text, kramdown_options).to_html
    end

    def kramdown_options
      {
        input: 'GFM',
        syntax_highlighter: 'rouge'
      }
    end

    def from_cache(key, &block)
      if (value = redis.get(key)).nil?
        value = yield(self)
        redis.set(key, Marshal.dump(value))
        redis.expire(key, EXPIRE)
        value
      else
        Marshal.load(value)
      end
    end

    def key(sha)
      "markdown:#{sha}"
    end

    def redis
      MarkdownCache.configuration.redis
    end
  end
end
