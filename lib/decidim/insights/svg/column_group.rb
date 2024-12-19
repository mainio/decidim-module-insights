# frozen_string_literal: true

module Decidim
  module Insights
    module Svg
      # Generates dynamically SVG images for column group graphs based on the
      # provided data.
      #
      # The column group graph displays the data horizontally similarly to the
      # column chart.
      class ColumnGroup < Graph
        attr_reader :height, :gap, :item_widths, :sections

        # With the default scale, the layout graph widths are 58 and 19
        def initialize(item_widths:, height: 500, gap: 20)
          @height = height
          @gap = gap
          @item_widths = item_widths
          @groups = []
        end

        # The group data should be provided in arrays that contain values for
        # each group. Each group needs to be the same size for the values to
        # be visible in the graph.
        def add_group(label, values)
          groups << { label:, values: }
        end

        def render
          @sections = []

          totals = groups.map { |g| g[:values] }.transpose.map(&:sum)
          groups.each do |group|
            items = group[:values].each_with_index.map do |item, idx|
              {
                proportion: item.to_f / totals[idx],
                width: item_widths[idx],
                color: pick_color(idx)
              }
            end

            @sections << {
              items:,
              label: group[:label]
            }
          end

          max_percentage = (
            @sections.map do |sect|
              sect[:items].map { |item| item[:proportion] }
            end.flatten.max * 100
          ).ceil

          # Get the graph's max value, rounded to closest 10
          scale_max = 10 * ((max_percentage + 10 - 1) / 10)
          scale_max = 100 if scale_max > 100

          # The height factor scales the graph columns to the full height of
          # the image. Otherwise each column would only take the percentage of
          # the item compared to 100% which would leave a lot of white space at
          # the top of the image.
          height_factor = scale_max.to_f / 100

          group_width = item_widths.sum
          width = ((group_width + gap) * @sections.length) - gap

          label_font_size = (0.4 * group_width).round
          label_line_height = (1.2 * label_font_size).round
          graph_height = height - label_line_height

          xpos = 0
          bar_groups = set_bar_groups(@sectionsm, height_factor, xpos)

          # Generate the scale labels within the graph
          scale_font_size = (0.06 * graph_height).round
          scale_steps = scale_max / 10
          scale_elements = []
          scale_steps.times do |step|
            number = scale_max - (step * 10)
            scale_pos = graph_height * (step.to_f / scale_steps)
            scale_elements << %(<text x="0" y="#{scale_pos}" baseline-shift="-95%" text-anchor="start" font-size="#{scale_font_size}">#{number} %</text>)
          end

          wrap_svg([width, height]) { "<g>#{scale_elements.join}</g><g>#{bar_groups.join}</g>" }
        end

        def assign_bar_groups(sections, height_factor, xpos)
          sections.each_with_index.map do |section, idx|
            paths = section[:items].map do |item|
              hei = graph_height * item[:proportion] / height_factor
              wid = item[:width]

              cmd = [
                "M #{xpos} #{graph_height}",
                "L #{xpos} #{graph_height - hei}",
                "L #{xpos + wid} #{graph_height - hei}",
                "L #{xpos + wid} #{graph_height}"
              ]

              xpos += wid

              %(<path fill="#{item[:color]}" d="#{cmd.join(" ")}" />)
            end
            xpos += gap

            label_pos = ((group_width + gap) * idx) + (group_width.to_f / 2)
            label = %(<text x="#{label_pos}" y="#{height}" text-anchor="middle" font-size="#{label_font_size}">#{section[:label]}</text>)

            %(<g>#{paths.join}#{label}</g>)
          end
        end

        private

        attr_reader :groups
      end
    end
  end
end
