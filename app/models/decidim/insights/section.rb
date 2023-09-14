# frozen_string_literal: true

module Decidim
  module Insights
    class Section < ApplicationRecord
      belongs_to :organization, foreign_key: :decidim_organization_id, class_name: "Decidim::Organization"
      has_many :areas, foreign_key: :decidim_insights_section_id, class_name: "Decidim::Insights::Area", inverse_of: :section, dependent: :destroy
      has_many :categories,
               foreign_key: "decidim_participatory_space_id",
               foreign_type: "decidim_participatory_space_type",
               dependent: :destroy,
               as: :participatory_space

      scope :with_organization, ->(organization) { where(organization: organization) }
    end
  end
end
