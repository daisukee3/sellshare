require 'rails_helper'

RSpec.describe 'ログイン', type: :request do
  describe 'ログイン' do
    let!(:user) { create(:user, email: 'taro@example.com' ) }

    it '正常なレスポンス(200status)を返すこと' do
      get user_session_path
      expect(response).to have_http_status(200)
    end

    it '有効なユーザーでログイン＆ログアウト' do
      get new_user_session_path
      post user_session_path, params: { user: { email: 'taro@example.com',
                                            password: 'password' } }
      redirect_to tweets_path
      follow_redirect!
      expect(response).to render_template('tweets/index')
      delete destroy_user_session_path
      get complaints_path
      redirect_to new_user_session_path
    end

    it '無効なユーザーでログイン' do
      get new_user_session_path
      post user_session_path, params: { user: { email: 'xxx@example.com',
                                            password: 'password' } }
      get complaints_path
      redirect_to new_user_session_path
    end
  end
end
