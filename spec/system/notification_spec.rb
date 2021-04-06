require 'rails_helper'

RSpec.describe 'Notification', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:tweet) { create(:tweet, user: other_user) }

  describe '通知一覧ページ' do
    context '通知生成' do
      before do
        sign_in user
      end
      context '自分以外のユーザーのtweetに対して' do
        before do
          visit tweet_path(tweet)
        end

        it 'いいねによって通知が作成されること' do
          expect(page).to have_css('.img-inactive-heart')
          find('.img-inactive-heart').click
          expect(page).to have_css('.img-active-heart')
          logout
          sign_in other_user
          visit notifications_path
          expect(page).to have_link("#{user.account}")
          expect(page).to have_content 'さんが'
          expect(page).to have_link('あなたの投稿')
          expect(page).to have_content 'にいいねしました'
        end

        it 'コメントによって通知が作成されること' do
          fill_in 'comment[content]', with: '頑張ろう'
          click_button 'コメントをする'
          within find('#comments_area') do
            expect(page).to have_css '.comment-container', count: 1
          end
          logout
          sign_in other_user
          visit notifications_path
          expect(page).to have_link("#{user.account}")
          expect(page).to have_content 'さんが'
          expect(page).to have_link('あなたの投稿')
          expect(page).to have_content 'にコメントしました'
        end
      end
      context '自分以外のユーザーに対して' do
        it 'フォローによって通知が作成されること' do
          visit account_path(other_user)
          expect(page).to have_content 'フォローする'
          find('.profilePage_followbtn_follow').click
          expect(page).to have_content 'フォロー中'
          logout
          sign_in other_user
          visit notifications_path
          expect(page).to have_link("#{user.account}")
          expect(page).to have_content 'さんが'
          expect(page).to have_content 'あなたをフォローしました'
        end
      end
    end
  end
end
