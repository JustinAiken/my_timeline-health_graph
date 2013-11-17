namespace "my_timeline-health_graph" do
  namespace :install do
    desc "Copy migrations from my_timeline-health_graph to application"
    task :migrations do
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")

      source    = File.expand_path "../../../../db/migrate/20131103010356_create_health_graph_cardio_activities.rb", File.dirname(__FILE__)
      dest      = File.expand_path "db/migrate/#{timestamp}_create_health_graph_cardio_activities.my_timeline.rb"
      puts "cp #{source} #{dest}"
      `cp #{source} #{dest}`
    end
  end
end
