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
        attr_reader :column_width, :gap, :height, :total, :pad_columns, :sections

        def initialize(column_width: 220, gap: 40, height: 500, total: nil, pad_columns: nil)
          @column_width = column_width
          @gap = gap
          @height = height
          @total = total
          @pad_columns = pad_columns
          @items = []
        end

        def add_item(label, value)
          items << { label:, value: }
        end

        def render
          calculated_total = total
          calculated_total ||= items.map { |item| item[:value] }.sum

          @sections = items.each_with_index.map do |item, idx|
            { label: item[:label], value: item[:value], proportion: item[:value].to_f / calculated_total, color: pick_color(idx) }
          end

          labels = @sections.map { |item| label_text_lines(item[:label]) }
          label_max_lines = labels.map(&:length).max

          label_font_size = (0.17 * column_width).round
          label_line_height = (1.2 * label_font_size).round
          label_height = (label_max_lines * label_line_height).round
          label_push = 0.5 * label_font_size # Needed for the text to display fully if it has tall characters ("p", "y", etc.)
          number_font_size = (0.338 * column_width).round
          number_margin = (0.6 * number_font_size).round
          top_gap = 1.4 * number_font_size

          max_proportion = @sections.map { |item| item[:proportion] }.max
          graph_height = height - top_gap - label_height - label_push

          xpos = 0
          columns = @sections.map.each_with_index do |item, idx|
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

            label = column_label(labels[idx], xpos:, ypos: top_gap + graph_height + label_line_height, font_size: label_font_size, line_height: label_line_height)

            xpos += column_width + gap

            %(<g>#{number}#{path}#{label}</g>)
          end

          wrap_svg([width, height]) { columns.join }
        end

        def width
          ((column_width + gap) * (items.length + (pad_columns || 0))) - gap
        end

        private

        attr_reader :items

        def column_label(text_lines, xpos:, ypos:, font_size:, line_height:)
          tspans = text_lines.each_with_index.map do |line, idx|
            if idx.positive?
              %(<tspan x="#{xpos}" dy="#{line_height}">#{line}</tspan>)
            else
              %(<tspan x="#{xpos}">#{line}</tspan>)
            end
          end

          %(<text x="#{xpos}" y="#{ypos}" text-anchor="start" font-size="#{font_size}">#{tspans.join}</text>)
        end

        # Splits the label into multiple lines if it is longer than the assigned
        # column width. The label has to be a maximum of the column width.
        def label_text_lines(text)
          character_width = (0.083 * column_width).round
          characters_per_row = (column_width.to_f / character_width).round

          parts = []
          current_part = ""
          text.split.each do |part|
            previous_part = current_part
            current_part = "#{current_part} #{part}".strip
            next if current_part.length <= characters_per_row

            parts << previous_part if previous_part.present?
            current_part = part
            pos = 0
            while current_part.length > characters_per_row
              parts << current_part[pos..(pos + characters_per_row)]
              current_part = current_part[(pos + characters_per_row)..-1]
            end
          end
          parts << current_part if current_part.present?

          parts
        end
      end
    end
  end
end
