class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @authorized_applications =
      Doorkeeper::Application
      .joins(:access_tokens)
      .where(oauth_access_tokens: { resource_owner_id: current_user.id, revoked_at: nil })
      .where("oauth_access_tokens.expires_in IS NULL OR oauth_access_tokens.created_at + INTERVAL oauth_access_tokens.expires_in SECOND > ?", Time.current)
      .distinct
  end
end
