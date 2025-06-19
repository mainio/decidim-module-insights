# frozen_string_literal: true

require "cell/partial"

module Decidim
  module Insights
    # This cell renders an area plan with its L-size card.
    class AreaPlanLCell < Decidim::Insights::AreaPlanMCell
      def card_classes
        classes = super
        classes = classes.split unless classes.is_a?(Array)
        (classes + ["card--full"]).join(" ")
      end

      private

      def default_resource_image_name
        "insights-area-plan-default-thumb-box.jpg"
      end

      def resource_image_variant
        :thumbnail_box
      end
    end
  end
end
