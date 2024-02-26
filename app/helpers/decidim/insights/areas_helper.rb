# frozen_string_literal: true

module Decidim
  module Insights
    module AreasHelper
      def slider_options
        { adjustHeight: true, breakpoints: { medium: { destroy: true }, large: { destroy: true } } }
      end
    end
  end
end
