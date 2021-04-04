require 'rails_helper'

RSpec.describe 'お気に入り登録機能', type: :request do
  let(:user) { create(:user) }
  let!(:tweet) { create(:tweet,  user: user) }

  context 'お気に入り登録処理' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'Tweetのお気に入り登録ができること' do
        expect {
          post "/api/tweets/#{tweet.id}/like"
        }.to change(user.likes, :count).by(1)
      end

      it 'Tweetのお気に入り解除ができること' do
        tweet.likes.create(user_id: user.id)
        expect {
          delete "/api/tweets/#{tweet.id}/like"
        }.to change(user.likes, :count).by(-1)
      end

    end
    context 'ログインしていない場合' do
      it 'お気に入り登録は実行できず、エラーメッセージ' do
        expect {
          post "/api/tweets/#{tweet.id}/like"
        }.not_to change(Like, :count)
        expect(response).to have_http_status(401)
      end

      it 'お気に入り解除は実行できず、エラーメッセージ' do
        expect {
          delete "/api/tweets/#{tweet.id}/like"
        }.not_to change(Like, :count)
        expect(response).to have_http_status(401)
      end
    end
  end

  context 'お気に入り一覧ページの表示' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'レスポンスが正常に表示されること' do
        get favorites_path
        expect(response).to have_http_status(200)
        expect(response).to render_template('favorites/index')
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面にリダイレクトすること' do
        get favorites_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
