require 'rails_helper'

RSpec.describe 'ユーザーの削除', type: :request do
  let!(:user) { create(:user) }

  describe 'Delete/User' do
    context '管理者ユーザーの場合' do
      let!(:admin_user) { create(:user, :admin) }

      before do
        sign_in admin_user
      end
      it 'ユーザーを削除後、ユーザー一覧ページにリダイレクト' do
        expect {
          delete user_path(user)
        }.to change(User, :count).by(-1)
        redirect_to users_url
        follow_redirect!
        expect(response).to render_template('users/index')
      end
    end

    context '管理者以外のユーザーの場合' do
      before do
        sign_in user
      end
      it '自分のアカウントを削除できること' do
        expect {
          delete user_path(user)
        }.to change(User, :count).by(0)
        redirect_to root_path
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログインページへリダイレクトすること' do
        expect {
          delete user_path(user)
        }.not_to change(User, :count)
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'Tweetが紐づくユーザーを削除した場合' do
      let!(:tweet) { create(:tweet,  user: user) }
      before do
        sign_in user
      end
      it 'ユーザーと同時に紐づくTweetも削除される' do
        expect {
          delete user_path(user)
        }.to change(Tweet, :count).by(0)
      end
    end
  end
end
