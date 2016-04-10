require 'markdown_cache/helper'

module MarkdownCache
  class Railtie < Rails::Railtie
    initializer "markdown_cache.helper" do
      ActionView::Base.send :include, Helper
    end
  end
end
