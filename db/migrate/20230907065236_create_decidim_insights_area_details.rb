# frozen_string_literal: true

class CreateDecidimInsightsAreaDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_insights_area_details do |t|
      t.references :decidim_insights_area, foreign_key: true, index: true
      t.integer :position, null: false, default: 0, index: true
      t.string :detail_type
      t.boolean :sticky, null: false, default: false
      t.jsonb :title
      t.jsonb :source
      t.jsonb :data

      t.timestamps
    end
  end
end
