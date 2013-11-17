require_relative 'cardio_activity_builder'

module MyTimeline
  module HealthGraph
    class HealthGraphScraper

      attr_accessor :user, :activities, :health_graph_user, :count

      def initialize(user)
        ::HealthGraph.configure do |config|
          config.client_id                  = '0e5a8f038da04633bd539ec664037ea9' #user.settings(:health_graph).client_id
          config.client_secret              = '838ad884eb644ebab93d09f302196244' #user.settings(:health_graph).client_secret
          config.authorization_redirect_url = ""
        end

        @user = user

        @health_graph_user = ::HealthGraph::User.new(user.settings(:health_graph).user_token)
      end

      def scrape(type = :cardio_activities)
        @count      = 0
        @activities = []

        case type
        when :cardio_activities   then scrape_runs
        when :strength_activities then scrape_strength
        end

        "Added #{count} #{type}"
      end

      def scrape_runs
        get_runs_from_rk
        activities.each do |activity|
          @count += 1 if cardio_builder.build_activity(activity)
        end
      end

      def scrape_strength
        #get_strongs_from_rk
        # activities.each do |activity|
        #   @count += 1 if strength_builder.build_activity(activity)
        # end
      end

      def get_runs_from_rk
        @feed     = health_graph_user.fitness_activities
        orig_feed = @feed.dup

        #Loop through the pages to get all activies
        # while @feed
          @activities += @feed.items
          # @feed = @feed.next_page
        # end

        @activities = orig_feed.send :unpack_items, @activities.reverse
      end

      def cardio_builder
        @cardio_builder ||= MyTimeline::HealthGraph::CardioActivityBuilder.new(user, health_graph_user)
      end

      def strength_builder
        #@strength_builder ||= MyTimeline::HealthGraphScraper::StrengthActivityBuilder.new(user)
      end
    end
  end
end
