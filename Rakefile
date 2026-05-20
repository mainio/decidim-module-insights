# frozen_string_literal: true

require "decidim/dev/common_rake"

def install_module(path, env = {})
  Dir.chdir(path) do
    # Disable Spring to evade reloading error.
    # (Spring reloads, and therefore needs the application to have reloading enabled.) This is disabled by default.

    system(env, "bundle exec rails decidim_favorites:install:migrations")
    system(env, "bundle exec rails decidim_locations:install:migrations")
    system(env, "bundle exec rails decidim_tags:install:migrations")
    system(env, "bundle exec rails decidim_insights:install:migrations")
    system(env, "bundle exec rails db:migrate")
  end
end

def seed_db(path)
  Dir.chdir(path) do
    system("bundle exec rake db:seed")
  end
end

desc "Generates a dummy app for testing"
task test_app: "decidim:generate_external_test_app" do
  ENV["RAILS_ENV"] = "test"
  install_module("spec/decidim_dummy_app", { "DISABLE_SPRING" => "1", "RAILS_ENV" => "test" })
end

desc "Generates a development app"
task :development_app do
  Bundler.with_original_env do
    generate_decidim_app(
      "development_app",
      "--app_name",
      "#{base_app_name}_development_app",
      "--path",
      "..",
      "--recreate_db",
      "--demo"
    )
  end

  install_module("development_app")
  seed_db("development_app")
end
