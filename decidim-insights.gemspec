# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/insights/version"

Gem::Specification.new do |s|
  s.version = Decidim::Insights.version
  s.authors = ["Antti Hukkanen"]
  s.email = ["antti.hukkanen@mainiotech.fi"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/decidim/decidim-module-insights"
  s.required_ruby_version = ">= 3.0"

  s.metadata["rubygems_mfa_required"] = "true"

  s.name = "decidim-insights"
  s.summary = "Regional information from Helsinki."
  s.description = "This module provides regional information about the Helsinki major districts."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Insights.decidim_version
end
