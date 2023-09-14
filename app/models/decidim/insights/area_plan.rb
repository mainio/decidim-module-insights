# frozen_string_literal: true

module Decidim
  module Insights
    class AreaPlan < ApplicationRecord
      include Decidim::HasUploadValidations
      include Decidim::ScopableResource
      include Decidim::HasAttachments
      include Decidim::Insights::HasCategory
      include Decidim::Comments::Commentable
      include Decidim::Favorites::Favoritable
      include Decidim::Tags::Taggable
      include Decidim::Locations::Locatable

      belongs_to :area, foreign_key: "decidim_insights_area_id", class_name: "Decidim::Insights::Area"

      has_one :section, through: :area, class_name: "Decidim::Insights::Section"
      has_one :organization, through: :area, class_name: "Decidim::Organization"

      has_one_attached :image
      validates_upload :image, uploader: Decidim::Insights::AreaPlanImageUploader

      def self.geocoded_data
        Decidim::Locations::Location.joins(
          Arel.sql(
            <<~SQL.squish
              INNER JOIN #{table_name} ON decidim_locations_locations.decidim_locations_locatable_type = '#{name}'
                AND decidim_locations_locations.decidim_locations_locatable_id = #{table_name}.id
            SQL
          )
        ).where(
          table_name => { id: where("1=1") }
        ).pluck(
          Arel.sql("#{table_name}.id"),
          Arel.sql("#{table_name}.title"),
          Arel.sql("#{table_name}.summary"),
          :address,
          :latitude,
          :longitude
        ).map do |location|
          {
            id: location[0],
            title: location[1],
            body: location[2],
            address: location[3],
            latitude: location[4],
            longitude: location[5]
          }
        end
      end
    end
  end
end
