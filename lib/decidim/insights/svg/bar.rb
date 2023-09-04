# frozen_string_literal: true

module Decidim
  module Insights
    module Svg
      # Generates dynamically SVG images for bar graphs based on the provided
      # data.
      #
      # The bar graph displays the data vertically. If you want horizontal
      # display for a similar type of graph, use the "column" graph.
      class Bar < Graph
        attr_reader :bar_height, :gap, :width, :total, :sections

        def initialize(bar_height: 32, gap: 51, width: 500, total: nil)
          @bar_height = bar_height
          @gap = gap
          @width = width
          @total = total
          @items = []
        end

        def add_item(label, value)
          items << { label: label, value: value }
        end

        def render
          calculated_total = total
          calculated_total ||= items.map { |item| item[:value] }.sum

          @sections = items.map do |item|
            # Note that the bar colors are the same on purpose. We use the first
            # available color.
            { label: item[:label], value: item[:value], proportion: item[:value].to_f / calculated_total, color: pick_color(0) }
          end

          number_font_size = (0.118 * width).round
          bar_gap = number_font_size * 0.1
          label_font_size = (0.048 * width).round
          label_line_height = 1.5 * label_font_size
          label_pull = (0.05 * number_font_size).round

          label_xpos = 0.344 * width

          ypos = 0
          bars = @sections.map do |item|
            tspans = label_text_lines(item[:label]).each_with_index.map do |line, idx|
              if idx.positive?
                %(<tspan x="#{label_xpos}" dy="#{label_line_height}">#{line}</tspan>)
              else
                %(<tspan x="#{label_xpos}">#{line}</tspan>)
              end
            end

            text_height = [number_font_size, tspans.length * label_line_height].max

            bar_width = width * item[:proportion]
            bar_top = ypos + text_height + bar_gap
            cmd = [
              "M 0 #{bar_top + bar_height}",
              "L 0 #{bar_top}",
              "L #{bar_width} #{bar_top}",
              "L #{bar_width} #{bar_top + bar_height}"
            ]
            path = %(<path fill="#{item[:color]}" d="#{cmd.join(" ")}" />)
            number = %(<text x="0" y="#{ypos}" baseline-shift="-80%" text-anchor="start" font-size="#{number_font_size}">#{item[:value]} %</text>)
            label = %(<text x="#{label_xpos}" y="#{ypos - label_pull}" baseline-shift="-95%" text-anchor="start" font-size="#{label_font_size}">#{tspans.join}</text>)

            ypos += text_height + bar_gap + bar_height + gap

            %(<g>#{number}#{label}#{path}</g>)
          end

          wrap_svg([width, ypos - gap]) { bars.join }
        end

        private

        attr_reader :items

        def label_text_lines(text)
          label_line_characters = 30 # how many characters per row (max)

          [].tap do |label_lines|
            current_line = []
            current_characters = 0
            text.split.each_with_index do |word, idx|
              current_characters += word.length
              current_characters += 1 if idx.positive?
              if current_characters > label_line_characters
                current_characters = 0
                label_lines << current_line.join(" ") if current_line.length.positive?
                current_line = []
              end
              current_line << word
            end
            label_lines << current_line.join(" ") if current_line.length.positive?
          end
        end
      end
    end
  end
end
