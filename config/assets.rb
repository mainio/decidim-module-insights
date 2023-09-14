# frozen_string_literal: true

base_path = File.expand_path("..", __dir__)

Decidim::Webpacker.register_path("#{base_path}/app/packs")
Decidim::Webpacker.register_entrypoints(
  decidim_insights: "#{base_path}/app/packs/entrypoints/decidim_insights.js",
  decidim_insights_area: "#{base_path}/app/packs/entrypoints/decidim_insights_area.js"
)
Decidim::Webpacker.register_stylesheet_import("stylesheets/decidim/insights/insights")
