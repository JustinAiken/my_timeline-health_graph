module MyTimeline
  module HealthGraph
    class Engine < ::Rails::Engine
      isolate_namespace MyTimeline::HealthGraph

      config.autoload_paths << File.expand_path("../../../app/classes/**", __FILE__)
      config.autoload_paths << File.expand_path("../../../app/scrapers/**", __FILE__)

      config.generators do |g|
        g.test_framework      :rspec,        fixture: false
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
        g.assets false
        g.helper false
      end

      config.after_initialize do |app|
        MyTimeline.config_object.key :health_graph, defaults: {user_token: nil}
        MyTimeline.register_plugin :health_graph
      end

      rake_tasks do
        load File::expand_path "railties/health_graph_tasks.rake", File.dirname(__FILE__)
      end
    end
  end
end
