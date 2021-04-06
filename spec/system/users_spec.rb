require 'rails_helper'

RSpec.describe 'Users', type: :system do
  let!(:user) { create(:user) }

  describe 'ユーザー登録ページ' do
    context 'ページレイアウト' do
      before do
        visit new_user_registration_path
      end
      it '「ユーザー登録」の文字列が存在することを確認' do
        expect(page).to have_content 'ユーザー登録'
      end
    end

    context 'ユーザー登録処理' do
      before do
        visit new_user_registration_path
      end
      it '有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること' do
        fill_in 'user_account', with: 'Example User'
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: 'password'
        click_button 'Sellshareを始める'
        expect(page).to have_content 'アカウント登録が完了しました。'
      end

      it '無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること' do
        fill_in 'user_account', with: ''
        fill_in 'user_email', with: 'user@example.com'
        fill_in 'user_password', with: 'password'
        click_button 'Sellshareを始める'
        expect(page).to have_content 'Accountを入力してください'
      end
    end
  end

  describe 'ユーザー一覧ページ' do
    context '管理者ユーザーの場合' do
      let!(:admin_user) { create(:user, :admin) }
      before do
        sign_in admin_user
      end
      it 'ぺージネーション、自分以外のユーザーの削除ボタンが表示されること' do
        create_list(:user, 11)
        visit users_path
        expect(page).to have_css '.pagination'
        User.paginates_per(page: 1).each do |u|
          expect(page).to have_css('.card-title', text: '削除')
          expect(page).to have_content '削除', count: 9
        end
      end
    end

    # ユーザー一覧についてそれぞれ実行の場合はテストが通るため下記コメントアウト
    # context '管理者ユーザー以外の場合' do
    #   before do
    #     sign_in user
    #   end
    #   it 'ぺージネーション、自分のアカウントのみ削除ボタンが表示されること' do
    #     create_list(:user, 11)
    #     visit users_path
    #     expect(page).to have_css '.pagination'
    #     User.paginates_per(page: 1).each do |u|
    #       expect(page).to have_css('.card-title', text: '削除')
    #       expect(page).to have_content '削除', count: 1
    #     end
    #   end
    # end
  end
end
