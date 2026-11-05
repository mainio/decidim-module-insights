# frozen_string_literal: true

module Decidim
  module Insights
    class Permissions < Decidim::DefaultPermissions
      def permissions
        return permission_action if permission_action.scope == :public && public_action_allowed?
        return permission_action unless user

        permission_action
      end

      private

      def public_action_allowed?
        return false unless permission_action.action == :read
        return false unless [:area, :plan].include?(permission_action.subject)

        allow!
      end
    end
  end
end
