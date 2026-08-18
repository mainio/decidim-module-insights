# frozen_string_literal: true

module Decidim
  module Insights
    class SectionConstraint
      def initialize(request)
        @request = request
      end

      def matches?
        return false unless current_organization
        return false unless section_slug

        Decidim::Insights::Section.exists?(
          organization: current_organization,
          slug: section_slug
        )
      end

      private

      def section_slug
        @request.path_parameters[:section_slug]
      end

      def current_organization
        @request.env["decidim.current_organization"]
      end
    end
  end
end
