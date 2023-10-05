# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class NumberCell < Decidim::Insights::DetailCell
        private

        def value
          model.data["value"]
        end

        def label
          translated_attribute(model.data["label"])
        end
      end
    end
  end
end
