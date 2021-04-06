require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :request do
  describe 'GET /users_signups' do
    it '200statusが返ってくる' do
      get new_user_registration_path
      expect(response).to have_http_status(200)
    end

    it '有効なユーザーで登録' do
      expect {
        post user_registration_path, params: { user: { account: 'Example User',
                                              email: 'user@example.com',
                                              password: 'password',
                                              password_confirmation: 'password' } }
      }.to change(User, :count).by(1)
      redirect_to @user
      follow_redirect!
      expect(response).to render_template('tweets/index')
    end

    it '無効なユーザーで登録' do
      expect {
        post user_registration_path, params: { user: { account: '',
                                            email: 'user@example.com',
                                            password: 'password',
                                            password_confirmation: 'pass' } }
      }.not_to change(User, :count)
    end
  end
end
