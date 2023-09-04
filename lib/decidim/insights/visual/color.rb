# frozen_string_literal: true

module Decidim
  module Insights
    module Visual
      # Color utility to convert colors into different formats and to calculate
      # the color luminance and contrast against another color. Also provides
      # utilities to mutate the color.
      class Color
        class << self
          def rgb(value)
            new(value)
          end

          def hex(value)
            new(value.match(/^#(..)(..)(..)$/).captures.map(&:hex))
          end

          # Converts HSV to RGB for presentation.
          #
          # See:
          # https://stackoverflow.com/a/62479718
          # https://cs.stackexchange.com/questions/64549/convert-hsv-to-rgb-colors
          def hsv(value)
            h, s, v = value.map(&:to_f)
            v *= 255
            calc = lambda { |n|
              k = (n + (h / 60)) % 6
              (v - (v * s * [[k, 4 - k, 1].min, 0].max)).round
            }

            new([calc.call(5), calc.call(3), calc.call(1)])
          end
        end

        attr_reader :rgb

        def initialize(rgb)
          @rgb = rgb
        end

        # Converts RGB to HEX for presentation.
        def hex
          rgb.map { |v| format("%02x", v) }.join.prepend("#")
        end

        # Converts RGB to HSV for easier color adjustments.
        #
        # See:
        # https://stackoverflow.com/a/62479718
        # https://math.stackexchange.com/questions/556341/rgb-to-hsv-color-conversion-algorithm
        def hsv
          @hsv ||= begin
            r, g, b = rgb.map(&:to_f)
            v = rgb.max.to_f
            n = v - rgb.min.to_f
            h = n.zero? ? 0 : (v == r ? (g - b) / n : (v == g ? 2 + ((b - r) / n) : 4 + ((r - g) / n))) # rubocop:disable Style/NestedTernaryOperator

            [(60 * (h.negative? ? h + 6 : h)).round, v.zero? ? 0 : n / v, v / 255]
          end
        end

        # Calculates the color luminance for the contrast calculations.
        def luminance
          gamma = rgb.each_with_index.map do |v|
            v <= 10 ? v.to_f / 3294 : ((v.to_f / 269) + 0.0513)**2.4
          end
          (0.2126 * gamma[0]) + (0.7152 * gamma[1]) + (0.0722 * gamma[2])
        end

        # Calculates the contrast difference against the other provided color
        # instance. Utility to analyze the color contrast for text against a
        # background color.
        #
        # @param color [Color] The other color to compare the contrast against.
        # @return [Float] The calculated color contrast.
        def contrast(other)
          lum1 = luminance
          lum2 = other.luminance
          brightest = [lum1, lum2].max
          darkest = [lum1, lum2].min

          (brightest + 0.05) / (darkest + 0.05)
        end

        # Darkens the HSV color with the given factor. E.g. if you give factor
        # 0.05, the color will be 5% darker. Uses trigonometry on the color
        # spectrum to calculate the distances and how much each value needs to
        # change. The `s` value represents the X axis and `v` value represents
        # the Y axis which allows us to calculate the new values with the travel
        # distance towards the bottom-right corner (i.e. full black).
        #
        # Note that this is a linear darkening algorithm towards the bottom
        # corner.
        #
        # @param factor [Float] A factor used as the basis for the calculation.
        #   When given e.g. 0.05, the resulting color will be 5% darker than the
        #   original color.
        # @return [Color] A new color instance with the darkened values.
        def darken(factor)
          h, s, v = hsv.map(&:to_f)
          distance = Math.sqrt(((1 - s)**2) + (v**2))
          travel = distance * factor
          angle = Math.tan((1 - s) / v)

          travel_s = Math.sin(angle) * travel
          travel_v = Math.cos(angle) * travel
          Color.hsv([h, [s + travel_s, 1].min, [v - travel_v, 1].min])
        end

        def darken!(factor)
          mutate!(darken(factor).rgb)
        end

        private

        def mutate!(adjusted_rgb)
          @rgb = adjusted_rgb
          remove_instance_variable(:@hsv)
          self
        end
      end
    end
  end
end
