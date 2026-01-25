require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "GET /" do
    context "when user is not authenticated" do
      it "redirects to login page" do
        get root_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is authenticated" do
      let(:user) { create(:user, name: "Test User", email: "test@example.com") }

      before do
        sign_in user
      end

      it "returns success" do
        get root_path

        expect(response).to have_http_status(:success)
      end

      it "displays user name" do
        get root_path

        expect(response.body).to include("Test User")
      end

      it "displays user email" do
        get root_path

        expect(response.body).to include("test@example.com")
      end

      it "displays edit profile link" do
        get root_path

        expect(response.body).to include("プロフィール編集")
      end

      it "displays logout button" do
        get root_path

        expect(response.body).to include("ログアウト")
      end

      it "displays no connected applications message when none exist" do
        get root_path

        expect(response.body).to include("連携しているアプリケーションはありません")
      end
    end

    context "when user has connected OAuth applications" do
      let(:user) { create(:user) }
      let(:oauth_application) { Doorkeeper::Application.create!(name: "Test App", redirect_uri: "https://example.com/callback", scopes: "openid") }

      before do
        sign_in user
        Doorkeeper::AccessToken.create!(
          application: oauth_application,
          resource_owner_id: user.id,
          scopes: "openid",
          expires_in: 7200
        )
      end

      it "displays connected application name" do
        get root_path

        expect(response.body).to include("Test App")
      end
    end
  end
end
