# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      module Charts
        class ColumnComparisonCell < Decidim::Insights::Details::ChartCell
          def chart
            render :chart
          end

          private

          def totals
            @totals ||= model.data["groups"].map { |data| data["values"] }.transpose.map(&:sum)
          end

          def chart_graph
            @chart_graph ||= Decidim::Insights::Svg::ColumnGroup.new(item_widths: [58, 19], gap: 20).tap do |graph|
              graph.colors = [
                "#0072c6", # coat
                "#f5a3c7" # suomenlinna
                # "#ed599a" # suomenlinna, darkened 20% due to WCAG violation for the text color
              ]
              model.data["groups"].each do |data|
                graph.add_group(data["group"], data["values"])
              end
            end
          end

          def chart_labels
            @chart_labels ||= begin
              rendered_chart # The chart needs to be rendered before it has sections
              first_group = chart_graph.sections.first[:items]

              model.data["labels"].each_with_index.map do |label, idx|
                {
                  color: fix_label_color(first_group[idx][:color]),
                  text: translated_attribute(label),
                  value: totals[idx]
                }
              end
            end
          end

          def labelled_groups
            @labelled_groups ||= begin
              group_label = translated_attribute(model.data["group_label"] || {}).presence || t("decidim.insights.details.charts.column_comparison.group")
              labels = set_labels(model)
              model.data["groups"].map do |data|
                {
                  group: data["group"],
                  title: "#{group_label}: #{data["group"]}",
                  values: (
                    data["values"].each_with_index.map do |value, idx|
                      {
                        value:,
                        percentage: 100 * value.to_f / totals[idx],
                        label: labels[idx]
                      }
                    end
                  )
                }
              end
            end
          end

          def assign_labels(model)
            aria_labels = (model.data["value_labels"].presence || []).map { |label| translated_attribute(label) }

            model.data["labels"].each_with_index.map do |default_label, idx|
              aria_labels[idx].presence || translated_attribute(default_label)
            end
          end

          # Color contrast fixer against the given background color to reach a
          # color contrast of 3:1. The comparison value's color would not pass
          # the color contrast requirements.
          def fix_label_color(color, background = "#ffffff")
            foreground_color = Visual::Color.hex(color)
            background_color = Visual::Color.hex(background)

            # Maximum of 20 times to reach full black starting from white with
            # 5% increments.
            20.times do
              break if foreground_color.hex == "#000000"

              # WCAG requires contrast of 3:1
              break if foreground_color.contrast(background_color) >= 3

              # Darken the color 5% for the next iteration
              foreground_color.darken!(0.05)
            end

            foreground_color.hex
          end
        end
      end
    end
  end
end
