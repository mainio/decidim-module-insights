# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class NumbersCell < Decidim::Insights::DetailCell
        private

        def items
          model.data
        end
      end
    end
  end
end
