# frozen_string_literal: true

module Decidim
  module Insights
    class DetailCell < Decidim::ViewModel
      include ActionView::Helpers::NumberHelper

      def show
        content_tag :div, class: "card #{card_classes.join(" ")}" do
          render :show
        end
      end

      def header
        return unless has_header?

        render :header
      end

      def footer
        return unless has_footer?

        render :footer
      end

      private

      def title_text
        @title_text ||= translated_attribute(model.title)
      end

      def source_text
        @source_text ||= translated_attribute(model.source)
      end

      def has_header?
        title_text.present?
      end

      def has_footer?
        source_text.present?
      end

      def card_classes
        %w(card--padded card--border).tap do |cls|
          cls << "card--hasfooter" if has_footer?
        end
      end
    end
  end
end
