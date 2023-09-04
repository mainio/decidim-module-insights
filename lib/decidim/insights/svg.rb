# frozen_string_literal: true

module Decidim
  module Insights
    # The svg module provides different types of SVG graphs to be used to
    # display the area data.
    module Svg
      autoload :Bar, "decidim/insights/svg/bar"
      autoload :Column, "decidim/insights/svg/column"
      autoload :ColumnGroup, "decidim/insights/svg/column_group"
      autoload :Donut, "decidim/insights/svg/donut"
      autoload :Graph, "decidim/insights/svg/graph"
    end
  end
end
