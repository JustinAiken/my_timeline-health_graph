module MyTimeline
  class HealthGraphController < MyTimeline::ApplicationController

    def new
      ::HealthGraph.configure do |config|
        config.client_id                  = MyTimeline::HealthGraph.client_id
        config.client_secret              = MyTimeline::HealthGraph.client_secret
        config.authorization_redirect_url = "#{root_url}/health_graph/code"
      end

      redirect_to ::HealthGraph.authorize_url
    end

    def show
      access_token = ::HealthGraph.access_token(params[:code])

      @user.settings(:health_graph).user_token = access_token
      @user.save!
      redirect_to control_panel_path, notice: "Connection Successful!"
    end

    def scrape
      scrape_status = MyTimeline::HealthGraph::HealthGraphScraper.new(@user).scrape
      redirect_to :back, notice: scrape_status
    end
  end
end
