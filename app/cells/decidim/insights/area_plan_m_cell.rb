# frozen_string_literal: true

require "cell/partial"

module Decidim
  module Insights
    # This cell renders an area plan with its M-size card.
    class AreaPlanMCell < Decidim::CardMCell
      private

      def card_wrapper
        cls = card_classes.is_a?(Array) ? card_classes.join(" ") : card_classes
        wrapper_options = { class: "card #{cls}", aria: { label: t(".card_label", title: title) } }
        if has_link_to_resource?
          link_to resource_path, **wrapper_options do
            yield
          end
        else
          aria_options = { role: "region" }
          content_tag :div, **aria_options.merge(wrapper_options) do
            yield
          end
        end
      end

      def title
        decidim_html_escape(translated_attribute(model.title))
      end

      def description
        summary = translated_attribute(model.summary).presence
        return decidim_sanitize(summary) if summary.present?

        model_body = strip_tags(translated_attribute(model.description))

        if options[:full_description]
          decidim_sanitize(model_body).gsub(/\n/, "<br>")
        else
          decidim_sanitize(truncate(model_body, length: 200))
        end
      end

      def resource_path
        resource_locator(model).path + request_params_query(resource_utm_params)
      end

      def request_params_query(params)
        return "" if params.empty?

        "?#{params.to_query}"
      end

      def has_footer?
        true
      end

      def has_image?
        true
      end

      def image_alt
        t(".image_alt", title: title)
      end

      def default_resource_image_name
        "insights-area-plan-default-thumb.jpg"
      end

      def default_resource_image_path
        if current_webpacker_instance.manifest.lookup(default_resource_image_name)
          asset_pack_path(default_resource_image_name)
        else
          asset_pack_path("media/images/#{default_resource_image_name}")
        end
      end

      def resource_image_path
        if model.image.attached?
          model.attached_uploader(:image).variant_url(resource_image_variant)
        else
          default_resource_image_path
        end
      end

      def resource_image_variant
        :thumbnail
      end

      def statuses
        [:comments_count, :favorites_count]
      end

      def comments_count_status
        render_comments_count
      end

      def creation_date_status
        l(model.published_at.to_date, format: :decidim_short)
      end

      def favorites_count_status
        cell("decidim/favorites/favorites_count", model)
      end

      def resource_utm_params
        return {} unless context[:utm_params]

        context[:utm_params].transform_keys do |key|
          "utm_#{key}"
        end
      end
    end
  end
end
