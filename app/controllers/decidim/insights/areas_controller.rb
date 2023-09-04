# frozen_string_literal: true

module Decidim
  module Insights
    # This controller manages the logic for displaying the areas and their data.
    class AreasController < Decidim::Insights::ApplicationController
      def index
        @areas = Area.all
      end

      def show
        @area = Area.find_by(key: params[:slug])
        raise ActionController::RoutingError, "Not Found" unless @area

        @demographic_data = @area.details.select { |detail| detail.group == "demographic" }
        @theme_data = @area.details.select { |detail| detail.group == "theme" }
      end
    end
  end
end
