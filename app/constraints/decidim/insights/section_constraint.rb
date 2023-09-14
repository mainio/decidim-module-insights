# frozen_string_literal: true

module Decidim
  module Insights
    class SectionConstraint
      def initialize(request)
        @request = request
      end

      def matches?
        return false unless current_organization

        slug_match = @request.path.match(%r{/([^/]+)})
        return false unless slug_match

        Decidim::Insights::Section.exists?(
          organization: current_organization,
          slug: slug_match[1]
        )
      end

      private

      def current_organization
        @request.env["decidim.current_organization"]
      end
    end
  end
end
