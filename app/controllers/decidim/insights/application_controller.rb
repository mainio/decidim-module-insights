# frozen_string_literal: true

module Decidim
  module Insights
    # This controller is the abstract class from which all other controllers of
    # this engine inherit.
    class ApplicationController < Decidim::ApplicationController
      include Decidim::TranslatableAttributes
    end
  end
end
