require 'rails_helper'

RSpec.describe 'ユーザー一覧', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /users_index' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
    
      it 'レスポンスが正常に表示されること' do
        get users_path
        expect(response).to render_template('users/index')
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログインページへリダイレクトすること' do
        get users_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
