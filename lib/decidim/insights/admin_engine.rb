# frozen_string_literal: true

module Decidim
  module Insights
    # This is the engine that runs on the public interface of `Insights`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Insights::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :insights do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "insights#index"
      end

      def load_seed
        nil
      end
    end
  end
end
