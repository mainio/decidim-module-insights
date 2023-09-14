# frozen_string_literal: true

module Decidim
  module Insights
    class AreaPlanImageUploader < RecordImageUploader
      set_variants do
        {
          default: { auto_orient: true, strip: true },
          thumbnail: { resize_to_fill: [650, 430], auto_orient: true, strip: true },
          main: { resize_to_fill: [1500, 920], auto_orient: true, strip: true }
        }
      end
    end
  end
end
