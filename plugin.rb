# name: restrict-moderator-permissions
# about: Restrict several permissions of moderators in a Discourse forum
# version: 0.0.1
# authors: xylocheles

after_initialize do
  ::Admin::StaffActionLogsController.class_eval do
    before_action :ensure_admin, if: -> { SiteSetting.restrict_moderator_permissions_cannot_access_staff_logs }
  end

  ::Guardian.class_eval do
    alias_method :old_can_export_entity?, :can_export_entity?
    def can_export_entity?(entity)
      # Regular users can only export their archives
      return false unless entity == "user_archive" or is_admin?

      old_can_export_entity?(entity)
    end
  end
end
