class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: 将来的にダッシュボード画面を実装
    # - アカウント情報
    # - 連携アプリ一覧
    # - セキュリティ設定
    # - ログイン履歴
    render plain: "Welcome, #{current_user.email}!"
  end
end
