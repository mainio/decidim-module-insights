# frozen_string_literal: true

module Decidim
  module Insights
    module PlansHelper
      def map_link_for(plan, options = {})
        return unless plan.locations.any?

        map_utility_static = Decidim::Map.static(organization: current_section.organization)
        return unless map_utility_static

        location = plan.locations.first
        map_utility_static.link(
          latitude: location.latitude,
          longitude: location.longitude,
          options: options
        )
      end
    end
  end
end
