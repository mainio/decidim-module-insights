# frozen_string_literal: true

base_path = File.expand_path("..", __dir__)

Decidim::Shakapacker.register_path("#{base_path}/app/packs")
Decidim::Shakapacker.register_entrypoints(
  decidim_insights: "#{base_path}/app/packs/entrypoints/decidim_insights.js",
  decidim_insights_area: "#{base_path}/app/packs/entrypoints/decidim_insights_area.js"
)
Decidim::Shakapacker.register_stylesheet_import("stylesheets/decidim/insights/insights")
