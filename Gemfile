# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

# Inside the development app, the relative require has to be one level up, as
# the Gemfile is copied to the development_app folder (almost) as is.
base_path = ""
base_path = "../" if File.basename(__dir__) == "development_app"
require_relative "#{base_path}lib/decidim/insights/version"

DECIDIM_VERSION = Decidim::Insights.decidim_version

gem "decidim", DECIDIM_VERSION
gem "decidim-insights", path: "."

gem "decidim-favorites", github: "mainio/decidim-module-favorites", branch: "main"
gem "decidim-locations", github: "mainio/decidim-module-locations", branch: "main"
gem "decidim-tags", github: "mainio/decidim-module-tags", branch: "main"

gem "bootsnap", "~> 1.17"

gem "puma", ">= 6.4.2"

# gem "faker", "~> 3.2"

# This is a temporary fix for: https://github.com/rails/rails/issues/54263
# Without this downgrade Activesupport will give error for missing Logger
gem "concurrent-ruby", "1.3.4"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "decidim-dev", DECIDIM_VERSION
  gem "decidim-initiatives", DECIDIM_VERSION

  gem "brakeman", "~> 5.2"
  gem "parallel_tests", "~> 4.2"

   # Fix issue with simplecov-cobertura
  # See: https://github.com/jessebs/simplecov-cobertura/pull/44
  gem "rexml", "3.4.1"

end

group :development do
  gem "faker", "~> 3.2.2"
  gem "letter_opener_web", "~> 2.0"
  gem "listen", "~> 3.8"
  gem "web-console", "~> 4.2"
  # gem "spring", "~> 2.0"
  # gem "spring-watcher-listen", "~> 2.0"
end
