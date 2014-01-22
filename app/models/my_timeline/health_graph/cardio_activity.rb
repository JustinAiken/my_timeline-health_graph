module MyTimeline
  module HealthGraph
    class CardioActivity < ActiveRecord::Base
      self.table_name = :my_timeline_health_graph_cardio_activities
      belongs_to :event, dependent: :destroy

      attr_protected unless rails4?

      def self.keep_original_time_zone?
        true
      end
    end
  end
end
