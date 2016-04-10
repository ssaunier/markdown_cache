require "redis"

module MarkdownCache
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    def redis=(options)
      @redis = Redis.new(options)
    end

    def redis
      @redis ||= Redis.new
    end
  end
end
