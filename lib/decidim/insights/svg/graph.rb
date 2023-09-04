# frozen_string_literal: true

module Decidim
  module Insights
    module Svg
      # Generic parent class for  all the graphs to provide some common methods.
      class Graph
        DEFAULT_COLORS = [
          "#0072c6", # coat
          "#ffe977", # engel
          "#008741", # tram
          "#9fc9eb", # fog
          "#c2a251", # gold
          "#00d7a7", # copper
          "#fd4f00", # metro
          "#bd2719", # brick
          "#ffc61e", # summer
          "#dedfe1" # silver
        ].freeze

        attr_writer :colors

        protected

        def wrap_svg(viewbox)
          %(<svg viewBox="0 0 #{viewbox * " "}">#{yield}</svg>)
        end

        def colors
          @colors ||= DEFAULT_COLORS
        end

        def pick_color(index)
          colors[index % colors.length]
        end
      end
    end
  end
end
