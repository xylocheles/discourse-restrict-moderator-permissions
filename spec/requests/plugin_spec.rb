# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Restrict Moderator Permissions" do
  before do
    SiteSetting.restrict_moderator_permissions_enabled=true
  end
  after do
    SiteSetting.refresh!
  end

  context 'while logged in as an admin' do
    fab!(:admin) { Fabricate(:admin) }

    before do
      sign_in(admin)
    end

    it 'allows admins to access staff action logs' do
      SiteSetting.restrict_moderator_permissions_cannot_access_staff_logs=true

      get '/admin/logs/staff_action_logs.json'
      expect(response.status).to eq(200)
    end
  end

  context 'while logged in as a moderator' do
    fab!(:moderator) { Fabricate(:moderator) }

    before do
      sign_in(moderator)
    end

    it 'forbids moderators to access staff action logs' do
      SiteSetting.restrict_moderator_permissions_cannot_access_staff_logs=true

      get '/admin/logs/staff_action_logs.json'
      expect(response.status).not_to eq(200)
    end
  end
end
