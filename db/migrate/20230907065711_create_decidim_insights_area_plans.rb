# frozen_string_literal: true

class CreateDecidimInsightsAreaPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_insights_area_plans do |t|
      t.references :decidim_insights_area, foreign_key: true, index: true
      t.references :decidim_scope, index: true
      t.jsonb :title
      t.jsonb :summary
      t.jsonb :description
      t.string :image

      t.integer :comments_count, null: false, default: 0, index: true

      t.timestamps
    end
  end
end
