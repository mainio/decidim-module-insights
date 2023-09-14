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

        def bubble_classes
          %w(bubble).tap do |cls|
            cls << "bubble--large" if bubble_text.length < 120
          end
        end

        def bubble_text
          @bubble_text ||= translated_attribute(model.data)
        end
      end
    end
  end
end
