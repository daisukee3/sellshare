require 'rails_helper'

RSpec.describe 'Tweet/edit', type: :request do
  let!(:user) { create(:user) }
  let!(:tweet) { create(:tweet, user: user) }

  context 'ログインしているユーザーの場合' do
    before do
      sign_in user
    end
    it 'レスポンスが正常に表示されること' do
      get edit_tweet_path(tweet)
      expect(response).to render_template('tweets/edit')
      patch tweet_path(tweet), params: { tweet: { content: '新規営業の難しさ' } }
      redirect_to tweet
      follow_redirect!
      expect(response).to render_template('tweets/index')
    end
  end

  context 'ログインしていないユーザーの場合' do
    it 'ログイン画面にリダイレクトすること' do
      # 編集
      get edit_tweet_path(tweet)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
      # 更新
      patch tweet_path(tweet), params: { tweet: { content: '新規営業の難しさ' } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_user_session_path
    end
  end

  context '別アカウントのユーザーの場合' do
    let!(:other_user) { create(:user) }
    before do
      sign_in other_user
    end
    it 'ホーム画面にリダイレクトすること' do
      # 編集
      get edit_tweet_path(tweet)
      expect(response).to have_http_status(302)
      expect(response).to redirect_to 'http://www.example.com/?locale=ja'
      # 更新
      patch tweet_path(tweet), params: { tweet: { content: '新規営業の難しさ' } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to 'http://www.example.com/?locale=ja'
    end
  end
end
