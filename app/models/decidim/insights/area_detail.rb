# frozen_string_literal: true

module Decidim
  module Insights
    class AreaDetail < ApplicationRecord
      include Decidim::Insights::HasCategory

      belongs_to :area, foreign_key: "decidim_insights_area_id", class_name: "Decidim::Insights::Area"

      has_one :section, through: :area, class_name: "Decidim::Insights::Section"
      has_one :organization, through: :area, class_name: "Decidim::Organization"

      scope :categorized, -> { joins(:category) }
      scope :uncategorized, lambda {
        joins(
          Arel.sql(
            <<~SQL.squish
              LEFT JOIN decidim_categorizations ON decidim_categorizations.categorizable_type = '#{name}'
                AND decidim_categorizations.categorizable_id = #{table_name}.id
            SQL
          )
        ).where(decidim_categorizations: { decidim_category_id: nil })
      }

      def display_cell
        case detail_type
        when "column_comparison", "bar", "column", "donut"
          "decidim/insights/details/charts/#{detail_type}"
        else
          "decidim/insights/details/#{detail_type}"
        end
      end
    end
  end
end
