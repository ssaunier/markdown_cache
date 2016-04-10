$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'markdown_cache'
require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new(color: true)]

require 'redis'
$redis = Redis.new
