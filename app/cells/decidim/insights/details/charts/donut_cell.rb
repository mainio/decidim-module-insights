# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      module Charts
        class DonutCell < Decidim::Insights::Details::ChartCell
          include Decidim::LayoutHelper

          def chart
            render :chart
          end

          def chart_icon
            return if icon_key.blank?

            render :chart_icon
          end

          private

          def icon_key
            model.data[:icon]
          end

          def chart_classes
            %w(chart--donut).tap do |cls|
              cls << "chart--small" if chart_labels.count > 4
            end
          end

          def chart_graph
            @chart_graph ||= Decidim::Insights::Svg::Donut.new.tap do |graph|
              model.data[:slices].each do |data|
                graph.add_slice(data[:value])
              end
            end
          end

          def chart_labels
            @chart_labels ||= begin
              rendered_chart # Ensure the chart is rendered

              chart_graph.slices.each_with_index.map do |slice, idx|
                slice_data = model.data[:slices][idx]

                {
                  color: slice[:color],
                  text: translated_attribute(slice_data[:label]),
                  value: slice[:proportion]
                }
              end
            end
          end
        end
      end
    end
  end
end
