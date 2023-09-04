# frozen_string_literal: true

module Decidim
  module Insights
    # This controller manages displaying the area plans and their data.
    class PlansController < Decidim::Insights::ApplicationController
      def show
        @area = Area.find_by(key: params[:area_slug])
      end
    end
  end
end
