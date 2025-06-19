# frozen_string_literal: true

require "cell/partial"

module Decidim
  module Insights
    # This cell renders the area plan card for an instance of a AreaPlan
    # the default size is the Medium Card (:m)
    class AreaPlanCell < Decidim::ViewModel
      def show
        cell card_size, model, options
      end

      private

      def card_size
        "decidim/insights/area_plan_m"
      end
    end
  end
end
