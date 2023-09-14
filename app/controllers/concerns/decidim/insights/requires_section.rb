# frozen_string_literal: true

module Decidim
  module Insights
    module RequiresSection
      extend ActiveSupport::Concern

      included do
        before_action :ensure_insights_section!

        helper_method :current_section
      end

      private

      def ensure_insights_section!
        raise ActionController::RoutingError, "Not Found" unless current_section
      end

      def current_section
        @current_section ||= Decidim::Insights::Section.find_by(
          organization: current_organization,
          slug: params[:section_slug]
        )
      end
    end
  end
end
