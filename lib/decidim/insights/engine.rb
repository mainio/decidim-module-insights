# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Insights
    # This is the engine that runs on the public interface of insights.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Insights

      routes do
        resources :areas, param: :slug, only: [:index, :show] do
          resources :plans, only: [:show]
        end
      end

      initializer "decidim_insights.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      initializer "decidim_insights.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Insights::Engine.root}/app/cells")
        # Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Insights::Engine.root}/app/views") # for partials
      end
    end
  end
end
