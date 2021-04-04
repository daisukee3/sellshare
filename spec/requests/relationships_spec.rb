require 'rails_helper'

RSpec.describe 'ユーザーフォロー機能', type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it 'ユーザーをフォローできること' do
      expect {
        user.follow!(other_user)
      }.to change(user.followings, :count).by(1)
    end

    it 'ユーザーのアンフォローができること' do
      user.follow!(other_user)
      expect {
        user.unfollow!(other_user)
      }.to change(user.followings, :count).by(-1)
    end

  end

  context 'ログインしていない場合' do
    it 'followingページへ飛ぶとログインページへリダイレクトすること' do
      get account_followings_path(user)
      expect(response).to redirect_to new_user_session_path
    end

    it 'followersページへ飛ぶとログインページへリダイレクトすること' do
      get account_follows_path(user)
      expect(response).to redirect_to new_user_session_path
    end
  end
end
