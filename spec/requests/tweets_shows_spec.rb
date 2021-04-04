require 'rails_helper'

RSpec.describe 'Tweet/show', type: :request do
  let!(:user) { create(:user) }
  let!(:tweet) { create(:tweet, user: user) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end
    it 'レスポンスが正常に表示されること' do
      get tweet_path(tweet)
      expect(response).to have_http_status(200)
      expect(response).to render_template('tweets/show')
    end
  end

  context 'ログインしていないユーザーの場合' do
    it 'ログイン画面にリダイレクトすること' do
      get tweet_path(tweet)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
