require "markdown_cache/version"
require "markdown_cache/configuration"
require "markdown_cache/renderer"

if defined?(Rails::Railtie)
  require "markdown_cache/railtie"
  require "markdown_cache/rails/engine" # For the assets
end
