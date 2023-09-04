# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class InfoCell < Decidim::Insights::DetailCell
        private

        def card_classes
          %w(card--padded bg-secondary).tap do |cls|
            cls << "card--hasfooter" if has_footer?
          end
        end
      end
    end
  end
end
