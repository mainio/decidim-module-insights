# frozen_string_literal: true

module Decidim
  module Insights
    module Svg
      # Generates dynamically SVG images for column graphs based on the provided
      # data.
      #
      # The column graph displays the data horizontally. If you want vertical
      # display for a similar type of graph, use the "bar" graph.
      class Column < Graph
        attr_reader :column_width, :gap, :height, :total, :sections

        def initialize(column_width: 220, gap: 40, height: 500, total: nil)
          @column_width = column_width
          @gap = gap
          @height = height
          @total = total
          @items = []
        end

        def add_item(label, value)
          items << { label: label, value: value }
        end

        def render
          calculated_total = total
          calculated_total ||= items.map { |item| item[:value] }.sum

          @sections = items.each_with_index.map do |item, idx|
            { label: item[:label], value: item[:value], proportion: item[:value].to_f / calculated_total, color: pick_color(idx) }
          end

          label_font_size = (0.17 * column_width).round
          label_height = (1.85 * label_font_size).round
          number_font_size = (0.338 * column_width).round
          number_margin = (0.6 * number_font_size).round
          top_gap = 1.4 * number_font_size

          max_proportion = @sections.map { |item| item[:proportion] }.max
          graph_height = height - top_gap - label_height

          xpos = 0
          columns = @sections.map do |item|
            # Adjust the bar heights based on the highest bar. The highest bar
            # should take the whole graph height.
            column_height = graph_height * (item[:proportion] / max_proportion)

            cmd = [
              "M #{xpos} #{top_gap + graph_height}",
              "L #{xpos} #{top_gap + graph_height - column_height}",
              "L #{xpos + column_width} #{top_gap + graph_height - column_height}",
              "L #{xpos + column_width} #{top_gap + graph_height}"
            ]

            path = %(<path fill="#{item[:color]}" d="#{cmd.join(" ")}" />)

            number_pos = [
              xpos + (column_width.to_f / 2),
              top_gap + graph_height - column_height - number_margin
            ]
            number = %(<text x="#{number_pos[0]}" y="#{number_pos[1]}" text-anchor="middle" font-size="#{number_font_size}">#{item[:value]} %</text>)

            label_pos = xpos
            label = %(<text x="#{label_pos}" y="#{height}" text-anchor="start" font-size="#{label_font_size}">#{item[:label]}</text>)

            xpos += column_width + gap

            %(<g>#{number}#{path}#{label}</g>)
          end

          wrap_svg([width, height]) { columns.join }
        end

        def width
          ((column_width + gap) * items.length) - gap
        end

        private

        attr_reader :items
      end
    end
  end
end
