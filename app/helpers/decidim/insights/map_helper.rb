# frozen_string_literal: true

module Decidim
  module Insights
    module MapHelper
      def markers_data(area, geocoded_plans)
        geocoded_plans.map do |data|
          {
            id: data[:id],
            title: translated_attribute(data[:title]),
            body: truncate(translated_attribute(data[:body]), length: 100),
            address: data[:address],
            latitude: data[:latitude],
            longitude: data[:longitude],
            link: area_plan_path(current_section.slug, area.slug, data[:id])
          }
        end
      end
    end
  end
end
