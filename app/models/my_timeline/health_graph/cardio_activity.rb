module MyTimeline
  module HealthGraph
    class CardioActivity < ActiveRecord::Base
      self.table_name = :my_timeline_health_graph_cardio_activities
      belongs_to :event, dependent: :destroy

      attr_protected unless rails4?
    end
  end
end
