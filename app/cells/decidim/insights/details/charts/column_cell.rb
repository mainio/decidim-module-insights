# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      module Charts
        class ColumnCell < Decidim::Insights::Details::Charts::BarCell
          private

          def chart_graph
            @chart_graph ||= Decidim::Insights::Svg::Column.new(total: model.data["scale"], pad_columns:).tap do |graph|
              graph.colors = [
                "#0072c6", # coat
                "#72a5cf", # fog-dark
                "#81bfcd" # didn't find this from the HDS colour tokens
              ]
              model.data["items"].each do |data|
                graph.add_item(translated_attribute(data["label"]), data["value"])
              end
            end
          end

          def pad_columns
            cols = model.data["items"].length
            return nil if cols >= 3

            3 - cols
          end
        end
      end
    end
  end
end
