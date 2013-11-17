$:.push File.expand_path("../lib", __FILE__)

require "my_timeline/health_graph/version"

Gem::Specification.new do |s|
  s.name        = "my_timeline-health_graph"
  s.version     = MyTimeline::HealthGraph::VERSION
  s.authors     = ["Justin Aiken"]
  s.email       = ["60tonangel@gmail.com"]
  s.homepage    = "https://www.github.com/JustinAiken/my_timeline-health_graph"
  s.summary     = "HealthGraph plugin for MyTimeline"
  s.description = "HealthGraph plugin for MyTimeline"

  s.license     = 'MIT'

  s.files       = `git ls-files`.split("\n")

  s.add_runtime_dependency "my_timeline"
  s.add_runtime_dependency "health_graph"
end
