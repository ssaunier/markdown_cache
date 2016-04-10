[![Build Status](https://travis-ci.org/ssaunier/markdown_cache.svg?branch=master)](https://travis-ci.org/ssaunier/markdown_cache)

## MarkdownCache

Simple and zero-configuration gem to quickly add Markdown rendering to your Rails views. Once installed, just use in any view:

```erb
<%= markdown "**Hello** _world_" %>
```

### Dependencies & Defaults

This gem uses `kramdown` and `rouge` and will require them automatically. **You also need a Redis server running** both locally and in production as this gem uses a redis-back cached.

The selected input format is **GitHub Flafored Markdown**.

### Setup

Add this to your `Gemfile`, then run `bundle install` :

```ruby
gem "markdown_cache", "~> 0.1"
```

You may use the provided CSS file for syntax highlighting (GitHub style) or download any pygments-compatible CSS stylesheet (`.highlight` CSS class):

```css
/*
 *= require markdown_cache
 */
```

By default, the gem will pick up the local Redis instance or the one defined with `REDIS_URL` but if you need to be specific, add an initializer to your Rails app, for instance:

```ruby
# config/initializers/markdown_cache.rb
if Rails.env.production?
  MarkdownCache.configure do |config|
    config.redis = { url: ENV['REDISCLOUD_URL'] }
  end
end
```

