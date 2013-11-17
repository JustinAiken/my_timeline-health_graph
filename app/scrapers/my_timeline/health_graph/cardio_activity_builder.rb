module MyTimeline
  module HealthGraph
    class CardioActivityBuilder

      attr_reader :user, :activity, :summary, :health_graph_user

      def initialize(user, health_graph_user)
        @health_graph_user = health_graph_user
        @user = user
      end

      def build_activity(activity)
        @activity = activity
        return false if already_exists_in_db?

        @summary = activity.summary

        event = MyTimeline::Event.create(
          happened_on:   activity.start_time,
          original_id:   activity.uri[19..26],
          external_link: "#{profile_base_url}/activity/#{activity.uri[19..26]}",
          icon_name:     ICONS[activity.type],
          importance:    5,
          public:        true,
          description:   build_description,
        )

        new_activity = MyTimeline::HealthGraph::CardioActivity.create(
          happened_on:   activity.start_time,
          duration:      activity.duration,
          meters:        activity.total_distance,
          uri:           activity.uri,
          calories:      summary.total_calories,
          climb:         summary.climb,
          equipment:     summary.equipment,
          activity_type: activity.type,
          notes:         summary.notes
        )

        event.linkable = new_activity
        event.user = user if MyTimeline.user_class
        event.save

        new_activity.event = event
        new_activity.save
      end

    private

      def already_exists_in_db?
        MyTimeline::HealthGraph::CardioActivity.find_by_uri(@activity.uri.to_s).present?
      end

      def build_description
        "".tap do |s|
          s << ACTIVITY_TEXT[activity.type]
          s << equip_string
          s << to_miles(activity.total_distance)
          s << " in #{to_time(activity.duration)}"
          s << calories_text
          s << notes
        end
      end

      def calories_text
        summary.total_calories  ? " and burned #{summary.total_calories.to_i} calories" : ""
      end

      def notes
        summary.notes ? " (#{summary.notes})" : ""
      end

      def to_miles(num)
        formatted = '%.2f' % (num * 0.000621371192)
        "#{formatted} miles"
      end

      def to_time(num)
        seconds = num % 60
        minutes = (num / 60) % 60
        hours   = num / (60 * 60)

        format "%02d:%02d:%02d", hours, minutes, seconds
      end

      ICONS = {
        "Running"    => "run.png",
        "Cycling"    => "cycle.png",
        "Walking"    => "walk.png",
        "Elliptical" => "elliptical.png"
      }

      ACTIVITY_TEXT = {
        "Running"    =>  "Ran ",
        "Cycling"    =>  "Cycled ",
        "Walking"    =>  "Strolled ",
        "Elliptical" =>  "Ran  "
      }

      def equip_string
        summary.equipment == "None" ? "" : "(on a #{summary.equipment.downcase}) "
      end

      def profile_base_url
        health_graph_user.profile.profile
      end
    end
  end
end
