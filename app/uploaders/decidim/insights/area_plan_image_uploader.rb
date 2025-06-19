# frozen_string_literal: true

module Decidim
  module Insights
    class AreaPlanImageUploader < RecordImageUploader
      set_variants do
        {
          default: { auto_orient: true, strip: true },
          thumbnail: { resize_to_fill: [860, 395], auto_orient: true },
          thumbnail_box: { resize_to_fill: [660, 450], auto_orient: true },
          main: { resize_to_fill: [1500, 920], auto_orient: true, strip: true }
        }
      end
    end
  end
end
