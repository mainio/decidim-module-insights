# frozen_string_literal: true

module Decidim
  module Insights
    module StructModel
      extend ActiveSupport::Concern

      class_methods do
        def find_by(**search)
          record = data.find { |details| details.slice(*search.keys).to_a == search.to_a }
          return nil unless record

          new(**record)
        end

        def where(**search)
          records = data.select { |details| details.slice(*search.keys).to_a == search.to_a }
          records.map do |record|
            new(**record)
          end
        end

        def all
          data.map { |details| new(**details) }
        end

        def data
          raise "Please implement the `data` method."
        end
      end

      def initialize(**attrs)
        # self = attrs
        attrs.each do |key, value|
          self[key] = value
        end
      end
    end
  end
end
