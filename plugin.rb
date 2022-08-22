# name: restrict-moderator-permissions
# about: Restrict several permissions of moderators in a Discourse forum
# version: 0.0.1
# authors: xylocheles

after_initialize do
  ::Admin::StaffActionLogsController.class_eval do
    before_action :ensure_admin, if: -> { SiteSetting.restrict_moderator_permissions_cannot_access_staff_logs }
  end
end
