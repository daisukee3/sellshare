require 'rails_helper'

RSpec.describe 'News_api', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /news_api' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'レスポンスが正常に表示' do
        get news_index_path
        expect(response).to render_template('news/index')
      end
    end
    context 'ログインしていないユーザーの場合' do
      it 'ログイン画面にリダイレクトされること' do
        get news_index_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
