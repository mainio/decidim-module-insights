# frozen_string_literal: true

module Decidim
  module Insights
    module HasCategory
      extend ActiveSupport::Concern

      include Decidim::HasCategory

      included do
        private

        def category_belongs_to_organization
          return unless category

          errors.add(:category, :invalid) unless section.categories.exists?(id: category.id)
        end
      end
    end
  end
end
