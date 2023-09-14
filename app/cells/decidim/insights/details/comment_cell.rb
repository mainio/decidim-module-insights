# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class CommentCell < Decidim::Insights::DetailCell
        private

        def bubble_classes
          %w(bubble).tap do |cls|
            cls << "bubble--large" if bubble_text.length < 120
            cls << "bubble--comment"
          end
        end

        def bubble_text
          @bubble_text ||= translated_attribute(model.data)
        end
      end
    end
  end
end
