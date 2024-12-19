# frozen_string_literal: true

module Decidim
  module Insights
    class Area < ApplicationRecord
      include Decidim::HasUploadValidations

      belongs_to :section, foreign_key: :decidim_insights_section_id, class_name: "Decidim::Insights::Section"
      has_many :details, foreign_key: :decidim_insights_area_id, class_name: "Decidim::Insights::AreaDetail", inverse_of: :area, dependent: :destroy
      has_many :plans, foreign_key: :decidim_insights_area_id, class_name: "Decidim::Insights::AreaPlan", inverse_of: :area, dependent: :destroy

      has_one :organization, through: :section, class_name: "Decidim::Organization"

      scope :with_section, ->(section) { where(section:) }

      has_one_attached :image
      validates_upload :image, uploader: Decidim::Insights::AreaImageUploader
    end
  end
end
