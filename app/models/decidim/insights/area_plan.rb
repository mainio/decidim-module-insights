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

      delegate :resource_manifest, to: :class

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

      # Required for the correct cell to show up in the user favorites section.
      #
      # We do not want these resources to be available in the global search
      # which is why they are not defined in the global resource registry.
      def self.resource_manifest
        # "Decidim::#{@entity.to_s.classify}Manifest".constantize
        # resource_registry.register(name, &block)

        # component.register_resource(:proposal) do |resource|
        #   resource.model_class_name = "Decidim::Proposals::Proposal"
        #   resource.template = "decidim/proposals/proposals/linked_proposals"
        #   resource.card = "decidim/proposals/proposal"
        #   resource.reported_content_cell = "decidim/proposals/reported_content"
        #   resource.actions = %w(endorse vote amend comment vote_comment)
        #   resource.searchable = true
        # end

        @resource_manifest ||= Decidim::ResourceManifest.new.tap do |resource|
          resource.model_class_name = name
          resource.card = "decidim/insights/area_plan"
          resource.searchable = false
        end
      end

      def mounted_engine
        "decidim_insights"
      end

      def mounted_params
        {
          host: organization.host,
          area_slug: area.slug,
          section_slug: section.slug
        }
      end

      # Replicates the same data for a single idea as returned for a collection
      # through the `#geocoded_data_for` method.
      def geocoded_data
        locations.map do |location|
          {
            id: id,
            title: title,
            body: summary,
            address: location.address,
            latitude: location.latitude,
            longitude: location.longitude
          }
        end
      end
    end
  end
end
