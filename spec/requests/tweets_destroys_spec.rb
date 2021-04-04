require 'rails_helper'

RSpec.describe 'Tweet/delete', type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:tweet) { create(:tweet, user: user) }

  context 'ログインしていて、自分のtweetを削除する場合' do
    before do
      sign_in user
    end
    it '処理が成功し、トップページにリダイレクトすること' do
      expect {
        delete tweet_path(tweet)
      }.to change(Tweet, :count).by(-1)
      redirect_to tweets_path
      follow_redirect!
      expect(response).to render_template('tweets/index')
    end
  end

  context 'ログインしていて、他人のtweetを削除する場合' do
    before do
      sign_in other_user
    end
    it '処理が失敗し、トップページへリダイレクトすること' do
      expect {
        delete tweet_path(tweet)
      }.not_to change(Tweet, :count)
      expect(response).to have_http_status(302)
      redirect_to tweets_path
      follow_redirect!
      expect(response).to render_template('tweets/index')
    end
  end

  context 'ログインしていない場合' do
    it 'ログインページへリダイレクトすること' do
      expect {
        delete tweet_path(tweet)
      }.not_to change(Tweet, :count)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
