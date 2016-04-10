# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markdown_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "markdown_cache"
  spec.version       = MarkdownCache::VERSION
  spec.authors       = ["Sebastien Saunier"]
  spec.email         = ["seb@saunier.me"]

  spec.summary       = %q{Markdown (GFM) view helper with redis-backed cache}
  spec.homepage      = "https://github.com/ssaunier/markdown_cache"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis", ">= 3.0"
  spec.add_dependency "kramdown", ">= 1.0"
  spec.add_dependency "rouge", ">= 1.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
end
