# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class CommentsCell < Decidim::Insights::DetailCell
        private

        def items
          model.data
        end
      end
    end
  end
end
