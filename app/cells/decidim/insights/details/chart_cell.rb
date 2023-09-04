# frozen_string_literal: true

module Decidim
  module Insights
    module Details
      class ChartCell < Decidim::Insights::DetailCell
        def labels
          return if chart_labels.blank?

          render :labels
        end

        private

        def rendered_chart
          @rendered_chart ||= chart_graph.render
        end

        def chart_graph
          raise "Please implement the `chart_graph` method for the chart."
        end

        def chart_labels
          []
        end
      end
    end
  end
end
