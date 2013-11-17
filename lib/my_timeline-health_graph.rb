require 'health_graph'

require "my_timeline"
require "my_timeline/health_graph/engine"

module MyTimeline
  module HealthGraph

    mattr_accessor :client_id, :client_secret

    def self.setup
      yield self
    end
  end
end
