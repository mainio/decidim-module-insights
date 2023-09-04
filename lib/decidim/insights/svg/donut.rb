# frozen_string_literal: true

module Decidim
  module Insights
    module Svg
      # Generates dynamically SVG images for donut graphs based on the provided
      # data.
      class Donut < Graph
        attr_reader :size, :radius, :inner_radius, :border, :slices

        def initialize(size: 500, border: 100)
          @size = size
          @radius = size / 2
          @border = border
          @inner_radius = radius - border
          @sections = []
        end

        def add_slice(value)
          sections << value
        end

        # This method produces the final SVG image for the provided sections
        # data. The data is automatically proportionized comparing each slice
        # to the total value (sum) of all slices.
        #
        # Example donut split to four 25% equal slices
        #   <svg viewBox="0 0 500 500">
        #     <path fill="#0072c6" d="M 250 0 A 250 250 0 0 1 500 250 L 400 250 A 150 150 0 0 0 250 100" />
        #     <path fill="#ffe977" d="M 500 250 A 250 250 0 0 1 250 500 L 250 400 A 150 150 0 0 0 400 250" />
        #     <path fill="#008741" d="M 250 500 A 250 250 0 0 1 0 250 L 100 250 A 150 150 0 0 0 250 400" />
        #     <path fill="#9fc9eb" d="M 0 250 A 250 250 0 0 1 250 0 L 250 100 A 150 150 0 0 0 100 250" />
        #   </svg>
        #
        # Note that the resulting SVG does not match exactly this example
        # because the PI calculations do not always produce even numbers due. It
        # does not matter in the final image and even numbers are used just for
        # simplicity in the example.
        #
        # Explanation of the paths (first path):
        # 1. Move the pointer to the top center of the image (250,0)
        #    -> M250 0
        # 2. Draw a curve (arc) clockwise (with the sweep flag) to the right
        #    center of the image (500,250) with a radii of 250 (0.5 of the
        #    image)
        #    -> A 250 250 0 0 1 500 250
        # 3. Move the pointer backwards to the middle of the image (400,250)
        #    to begin the inner curve backwards (with border width of 100)
        #    towards the starting point
        #    -> L 400 250
        # 4. Draw the inner curve (arc) counterclockwise (without sweep flag) to
        #    100px (border width) from the starting point with a radii of 150
        #    (250 outer curve minus border width of 100)
        #    -> A 150 150 0 0 0 250 100
        #
        # @returns [String] The resulting SVG image data as string.
        def render
          # Store the slices data to a variable if there is a need to access the
          # information about the slices (such as their colors) outside of this
          # class, e.g. for displaying the labels.
          @slices = render_data

          outer_arc_size = [(size / 2)] * 2
          inner_arc_size = [(size / 2) - border] * 2
          paths = slices.map do |slice|
            large_arc = slice[:angle_increment] < -180 ? 1 : 0
            cmd = [
              "M #{slice[:edges][0] * " "}",
              "A #{outer_arc_size * " "} 0 #{large_arc} 1 #{slice[:edges][1] * " "}",
              "L #{slice[:edges][2] * " "}",
              "A #{inner_arc_size * " "} 0 #{large_arc} 0 #{slice[:edges][3] * " "}"
            ]

            %(<path fill="#{slice[:color]}" d="#{cmd.join(" ")}" />)
          end

          wrap_svg([size] * 2) { paths.join }
        end

        private

        attr_reader :sections

        def render_data
          angle = 90 # Top of the circle

          proportional_sections.each_with_index.map do |proportion, idx|
            # Clockwise rotation of the slices means rotating from the current
            # position in negative degrees.
            angle_increment = -proportion * 360

            # Edges:
            # 0 = starting point
            # 1 = end of outer curve
            # 2 = start of inner curve
            # 4 = end of inner curve
            slice = {
              proportion: proportion,
              angle: angle,
              angle_increment: angle_increment,
              edges: [
                position_at(angle),
                position_at(angle + angle_increment),
                position_at(angle + angle_increment, inner: true),
                position_at(angle, inner: true)
              ],
              color: pick_color(idx)
            }

            # Move the starting angle for the next slice to the end of the
            # current slice.
            angle += angle_increment

            slice
          end
        end

        def proportional_sections
          total = sections.sum
          sections.map { |num| num.to_f / total }
        end

        def position_at(angle, inner: false)
          angle += 360 if angle.negative?
          current_radius = inner ? inner_radius : radius

          [
            radius + (Math.cos(angle * Math::PI / 180) * current_radius),
            radius - (Math.sin(angle * Math::PI / 180) * current_radius)
          ]
        end
      end
    end
  end
end
