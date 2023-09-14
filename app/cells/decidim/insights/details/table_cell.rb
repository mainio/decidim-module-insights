# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class TableCell < Decidim::Insights::DetailCell
        private

        def total
          @total ||= model.data.map { |d| d["value"] }.sum
        end

        def proportional_value(value)
          (100 * value.to_f / total).round(2)
        end

        def ordered_data
          @ordered_data ||= begin
            data = model.data.map do |item|
              item["proportion"] = proportional_value(item["value"])
              item
            end

            data.select { |item| item["value"].positive? }.sort { |a, b| a["value"] <=> b["value"] }.reverse
          end
        end
      end
    end
  end
end
