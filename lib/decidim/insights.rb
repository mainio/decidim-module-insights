# frozen_string_literal: true

require "decidim/insights/admin"
require "decidim/insights/engine"
require "decidim/insights/admin_engine"

module Decidim
  # This namespace holds the logic of the `Insights` component. This component
  # allows users to create insights in a participatory space.
  module Insights
    autoload :Svg, "decidim/insights/svg"
    autoload :Visual, "decidim/insights/visual"
  end
end

Decidim.register_global_engine(
  :insights,
  Decidim::Insights::Engine,
  at: "/"
)
