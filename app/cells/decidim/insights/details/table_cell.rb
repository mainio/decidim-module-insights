# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class TableCell < Decidim::Insights::DetailCell
        private

        def total
          @total ||= model.data.map { |d| d[:value] }.sum
        end

        def proportional_value(value)
          (100 * value.to_f / total).round(2)
        end
      end
    end
  end
end
