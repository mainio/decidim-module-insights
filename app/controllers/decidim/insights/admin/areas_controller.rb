# frozen_string_literal: true

module Decidim
  module Insights
    module Admin
      class AreasController < Decidim::Insights::Admin::ApplicationController
        def index
          enforce_permission_to :read, :insights_area_list
        end

        def new
          enforce_permission_to :create, :insights_area
        end

        def create
          enforce_permission_to :create, :insights_area
        end

        def edit
          enforce_permission_to :update, :insights_area
        end

        def update
          enforce_permission_to :update, :insights_area
        end
      end
    end
  end
end
