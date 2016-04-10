module MarkdownCache
  module Helper
    def markdown(text)
      renderer = Renderer.new
      renderer.render(text).html_safe
    end
  end
end
