require 'rails_helper'

RSpec.describe 'Profile', type: :system do
  let!(:user) { create(:user, :with_profile) }

  context 'ログインしている場合' do
    before do
      sign_in user
    end

    it '自分のプロフィール情報を確認できる' do
      visit profile_path
      expect(page).to have_css('.profilePage_user_displayName', text: user.account)
      expect(page).to have_css('.profilePage_user_introduction', text: user.profile.introduction)
      expect(page).to have_css('.profilePage_user_basicInfo', text:  I18n.t("enum.genders.#{user.gender}"))
      expect(page).to have_css('.profilePage_user_basicInfo', text: I18n.t("enum.ages.#{user.age}"))
      expect(page).to have_css('.profilePage_user_basicInfo', text: I18n.t("enum.types.#{user.type}"))
    end

    it '有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること' do
      visit edit_profile_path
      fill_in 'profile[introduction]', with: '提案営業やってます'
      select '男性', from: 'profile[gender]'
      select '20代', from: 'profile[age]'
      select 'メーカー', from: 'profile[type]'
      click_button '保存'
      expect(page).to have_content '更新完了'
      expect(user.reload.profile.introduction).to eq '提案営業やってます'
      expect(user.reload.profile.gender).to eq 'male'
      expect(user.reload.profile.age).to eq 'twenties'
      expect(user.reload.profile.type).to eq 'maker'
    end
  end

  context 'ユーザーのフォロー/アンフォロー処理', js: true do
    let!(:other_user) { create(:user) }
    before do
      sign_in user
    end
    it 'ユーザーのフォロー/アンフォローができ,変更によりカウント表示が変わること' do
      visit account_path(other_user)
      expect(page).to have_content 'フォローする'
      find('.profilePage_followbtn_follow').click
      expect(page).to have_css('.profilePage_follower_count', text: 1)
      expect(page).to have_content 'フォロー中'
      find('.profilePage_followbtn_following').click
      expect(page).to have_content 'フォローする'
      expect(page).to have_css('.profilePage_follower_count', text: 0)
    end
  end
end
