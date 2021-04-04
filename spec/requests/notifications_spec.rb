require 'rails_helper'

RSpec.describe '通知機能', type: :request do
  let!(:user) { create(:user) }

  context '通知一覧ページの表示' do
    context 'ログインしているユーザーの場合' do
      before do
        sign_in user
      end

      it 'レスポンスが正常に表示されること' do
        get notifications_path
        expect(response).to render_template('notifications/index')
      end
    end

    context 'ログインしていないユーザーの場合' do
      it 'ログインページへリダイレクトすること' do
        get notifications_path
        expect(response).to have_http_status(302)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  context '通知処理' do
    before do
      sign_in user
    end

    context '自分以外のユーザーのtweetに対して' do
      let!(:other_user) { create(:user) }
      let!(:tweet) { create(:tweet, user: other_user) }
      it 'いいねによって通知が作成されること' do
        post "/api/tweets/#{tweet.id}/like", xhr: true
        expect(other_user.reload.active_notifications).to be_truthy
      end

      it 'コメントによって通知が作成されること' do
        post tweet_comments_path(tweet), xhr: true, params: { comment: { content: '頑張ろう' } }
        expect(other_user.reload.active_notifications).to be_truthy
      end
    end

    context '自分以外のユーザーに対して' do
      let!(:other_user) { create(:user) }
      it 'フォローによって通知が作成されること' do
        user.follow!(other_user)
        expect(other_user.reload.active_notifications).to be_truthy
      end
    end
  end
end