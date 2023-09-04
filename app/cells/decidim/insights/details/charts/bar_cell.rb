# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      module Charts
        class BarCell < Decidim::Insights::Details::ChartCell
          private

          def chart_graph
            @chart_graph ||= Decidim::Insights::Svg::Bar.new(total: model.data[:scale]).tap do |graph|
              model.data[:items].each do |data|
                graph.add_item(translated_attribute(data[:label]), data[:value])
              end
            end
          end
        end
      end
    end
  end
end
