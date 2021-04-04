require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let!(:user) { create(:user) }

  describe 'ログインページ' do
    context 'ページレイアウト' do
      before do
        visit new_user_session_path
      end
      it '「ログイン」の文字列が存在することを確認' do
        expect(page).to have_content 'ログイン'
      end

      it 'ヘッダーにログインページへのリンクがあることを確認' do
        expect(page).to have_link 'ログイン', href: '/users/sign_in?locale=ja'
      end

      it 'ヘッダーにユーザー登録ページへのリンクがあることを確認' do
        expect(page).to have_link '登録する', href: '/users/sign_up?locale=ja'
      end

      it 'ログインフォームのラベルが正しく表示される' do
        expect(page).to have_content 'Eメール'
        expect(page).to have_content 'パスワード'
      end

      it 'ログインフォームが正しく表示される' do
        expect(page).to have_css 'input#user_email'
        expect(page).to have_css 'input#user_password'
      end

      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン処理' do
      before do
        visit new_user_session_path
      end
      it '無効なユーザーでログインを行うとログインが失敗することを確認' do
        fill_in 'user[email]', with: 'user@example.com'
        fill_in 'user[password]', with: 'pass'
        click_button 'ログイン'
        expect(page).to have_content 'Eメールまたはパスワードが違います。'
      end

      it '有効なユーザーでログインできることを確認' do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
      end
    end
  end
end
