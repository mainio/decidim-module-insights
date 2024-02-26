# frozen_string_literal: true

module Decidim
  module Insights
    # This controller manages displaying the area plans and their data.
    class PlansController < Decidim::Insights::ApplicationController
      include Decidim::Insights::RequiresSection

      helper Decidim::MapHelper
      helper Decidim::Insights::MapHelper
      helper Decidim::Comments::CommentsHelper

      helper_method :current_area

      before_action :set_breadcrumbs, only: [:show]

      def index
        raise ActionController::RoutingError, "Not Found" unless current_area

        redirect_to area_path(current_section.slug, current_area.slug, anchor: "plans")
      end

      def show
        raise ActionController::RoutingError, "Not Found" unless current_area

        @plan = current_plan
        raise ActionController::RoutingError, "Not Found" unless @plan
      end

      private

      def current_area
        @current_area ||= Area.find_by(slug: params[:area_slug])
      end

      def current_plan
        @current_plan ||= current_area.plans.find_by(id: params[:id])
      end

      def set_breadcrumbs
        return unless respond_to?(:add_breadcrumb, true)
        return unless current_section
        return unless current_area
        return unless current_plan

        add_breadcrumb(t("decidim.insights.areas.index.breadcrumb"), areas_path(current_section.slug))
        add_breadcrumb(translated_attribute(current_area.title), area_path(current_section.slug, current_area.slug))
        add_breadcrumb(translated_attribute(current_plan.title), area_plan_path(current_section.slug, current_area.slug, current_plan))
      end
    end
  end
end
