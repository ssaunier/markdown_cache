require 'test_helper'

class MarkdownCacheTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MarkdownCache::VERSION
  end
end
