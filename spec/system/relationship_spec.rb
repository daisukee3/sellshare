require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:user3) { create(:user) }
  let!(:user4) { create(:user) }

  describe 'フォロー中(following一覧)ページ' do
    before do
      sign_in user
      create(:relationship, follower_id: user.id, following_id: user2.id)
      create(:relationship, follower_id: user.id, following_id: user3.id)
      visit account_followings_path(user)
    end

    context 'ページレイアウト' do
      it '「フォロー中」の文字列が存在すること' do
        expect(page).to have_content 'フォロー中'
      end

      it 'フォロー中のユーザーが表示されていること' do
          user.followings.each do |u|
          page.has_link?('.card-title')
        end
      end
    end
  end

  describe 'フォロワー(followers一覧)ページ' do
    before do
      sign_in user
      create(:relationship, follower_id: user2.id, following_id: user.id)
      create(:relationship, follower_id: user3.id, following_id: user.id)
      create(:relationship, follower_id: user4.id, following_id: user.id)
      visit account_follows_path(user)
    end

    context 'ページレイアウト' do
      it '「フォロワー」の文字列が存在すること' do
        expect(page).to have_content 'フォロワー'
      end

      it 'フォロワーが表示されていること' do
        user.followers.each do |u|
          page.has_link?('.card-title')
        end
      end
    end
  end
end
