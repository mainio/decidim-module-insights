# frozen_string_literal: true

module Decidim
  module Insights
    class AreaImageUploader < ImageUploader
      def content_type_allowlist
        %w(image/jpeg image/png image/svg+xml)
      end

      def extension_allowlist
        %w(jpeg jpg png svg)
      end
    end
  end
end
