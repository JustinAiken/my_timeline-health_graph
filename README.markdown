[![Code Climate](https://codeclimate.com/github/JustinAiken/my_timeline-health_graph.png)](https://codeclimate.com/github/JustinAiken/my_timeline-health_graph)

# My Timeline - Health Graph Plugin
#### Health Graph Integration with My Timeline

### Requirements:
- [My Timeline](https://github.com/JustinAiken/my_timeline)
- HealthGraph Client API Key/Secret - Get one [here](http://developer.runkeeper.com/healthgraph/registration-authorization)

### Usage:

1. Add this gem to your Gemfile:
`gem 'my_timeline-health_graph'` and `bundle install`
2. Add jupp0r's health_graph library to your Gemfile:
`gem 'health_graph', git: 'git://github.com/jupp0r/health_graph.git'`
3. Edit `config/initializers/my_timeline.rb` to include your API keys:

```ruby
MyTimeline.setup do |config|
  ...
end

MyTimeline::HealthGraph.setup do |config|
  config.client_id     = "lotsofrandomhexchars"
  config.client_secret = "lotsofrandomhexchars"
end
```

## Credits

Original author: [Justin Aiken](https://github.com/JustinAiken)

## Links

* [Source](https://github.com/JustinAiken/my_timeline-health_graph)
* [Bug Tracker](https://github.com/JustinAiken/my_timeline-health_graph/issues)
* [Rubygem](https://rubygems.org/gems/my_timeline-health_graph)

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  * If you want to have your own version, that is fine but bump version in a commit by itself so I can ignore when I pull
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2013 Justin Aiken Inc. MIT license (see LICENSE for details).
