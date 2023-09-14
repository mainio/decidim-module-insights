# frozen_string_literal: true

module Decidim
  module Insights
    # This controller manages the logic for displaying the areas and their data.
    class AreasController < Decidim::Insights::ApplicationController
      include Decidim::Paginable
      include Decidim::Insights::RequiresSection

      helper Decidim::MapHelper
      helper Decidim::TooltipHelper

      helper_method :areas, :detail_categories, :details_filter

      before_action :set_breadcrumbs, only: [:index, :show]

      def index
        raise ActionController::RoutingError, "Not Found" unless areas.any?
      end

      def show
        @area = current_area
        raise ActionController::RoutingError, "Not Found" unless @area

        @uncategorized_data = @area.details.uncategorized.order(:position).uniq
        @categorized_data = filtered_details

        @geocoded_plans = @area.plans.geocoded_data
        @plans = paginate(@area.plans)
      end

      def details
        @area = areas.find_by(slug: params[:area_slug])
        raise ActionController::RoutingError, "Not Found" unless @area

        @details = filtered_details
      end

      private

      def set_breadcrumbs
        return unless respond_to?(:add_breadcrumb, true)
        return unless current_section

        add_breadcrumb(t("decidim.insights.areas.index.breadcrumb"), areas_path(current_section.slug))
        return unless action_name == "show"
        return unless current_area

        add_breadcrumb(translated_attribute(current_area.title), area_path(current_section.slug, current_area.slug))
      end

      def current_area
        @current_area ||= areas.find_by(slug: params[:slug])
      end

      def areas
        current_section.areas.order(:position)
      end

      def filtered_details
        @filtered_details ||=
          if details_filter[:category].present?
            @area.details.with_category(details_filter[:category]).order(:position).uniq
          else
            @area.details.categorized.where(sticky: true).order("decidim_categories.weight", :position).uniq
          end
      end

      def details_filter
        @details_filter ||= params[:filter].present? ? params.require(:filter).permit(:category) : {}
      end

      def detail_categories
        Decidim::Category.joins(:categorizations).where(
          participatory_space: current_section,
          decidim_categorizations: {
            categorizable_type: "Decidim::Insights::AreaDetail",
            categorizable_id: @area.details
          }
        ).order(:weight).uniq
      end
    end
  end
end
