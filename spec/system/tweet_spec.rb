require 'rails_helper'

RSpec.describe 'Tweet', type: :system do
  let!(:user) { create(:user, :with_profile) }

  describe 'Tweet/index' do
    let!(:tweets) { create_list(:tweet, 15,  user: user) }
    it 'tweet一覧が表示される' do
      visit root_path
      expect(page).to have_css '.card', count: 10
    end

    it 'Tweetのページネーションが表示されていることを確認' do
      visit root_path
      expect(page).to have_css '.pagination'
    end
  end

  describe 'Tweet/show' do
    let!(:tweet) { create(:tweet, user: user) }
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'tweet詳細を表示できる' do
        visit root_path
        find('.card_content').click
        expect(page).to have_css('.tweet_content', text: tweet.content)
      end

      it 'Tweetの情報が表示されていることを確認' do
        visit root_path
        Tweet.take(10).each do |tweet|
          expect(page).to have_css('.card_content', text: tweet.content)
        end
      end
    end
  end

  describe 'Tweet/new' do
    before do
      sign_in user
      visit new_tweet_path
    end

    context 'ページレイアウト' do
      it '入力部分に適切なラベルが表示されること' do
        expect(page).to have_content '画像'
        expect(page).to have_content '内容'
        expect(page).to have_button '投稿する'
      end
    end

    context 'Tweet登録処理' do
      it '有効な情報でTweet登録を行うと登録成功のフラッシュが表示されること' do
        fill_in 'tweet[content]', with: '新規営業が辛いです'
        click_button '投稿する'
        expect(page).to have_content '保存完了'
      end

      it '無効な情報でTweet登録を行うと登録失敗のフラッシュが表示されること' do
        fill_in 'tweet[content]', with: ''
        click_button '投稿する'
        expect(page).to have_content '保存失敗'
      end
    end
  end

  describe 'Tweet/edit' do
    let!(:tweet) { create(:tweet, user: user) }
    context 'ページレイアウト' do
      before do
        sign_in user
        visit tweet_path(tweet)
        find('.dropBtn').hover
        click_link '編集する'
      end
      it '入力部分に適切なラベルが表示されること' do
        expect(page).to have_content '画像'
        expect(page).to have_content '内容'
        expect(page).to have_button '投稿する'
      end
    end

    context 'Tweetの更新処理' do
      before do
        sign_in user
        visit tweet_path(tweet)
        find('.dropBtn').hover
        click_link '編集する'
      end
      it '有効な更新' do
        fill_in 'tweet[content]', with: 'お客さんと雑談ができない'
        click_button '投稿する'
        expect(page).to have_content '更新完了'
        expect(tweet.reload.content).to eq 'お客さんと雑談ができない'
      end

      it '無効な更新' do
        fill_in 'tweet[content]', with: ''
        click_button '投稿する'
        expect(page).to have_content '更新失敗'
        expect(tweet.reload.content).not_to eq ''
      end
    end
  end

  describe 'Tweet/delete' do
    let!(:tweet) { create(:tweet, user: user) }
    before do
      sign_in user
      visit tweet_path(tweet)
      find('.dropBtn').hover
      click_link '削除する'
    end
    context 'Tweetの削除処理', js: true do
      it '削除成功のフラッシュが表示されること' do
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '投稿を削除完了'
      end
    end
  end

  describe 'Tweet/like' do
    let!(:tweet) { create(:tweet, user: user) }
    before do
      sign_in user
      visit tweet_path(tweet)
    end
    context 'お気に入り登録/解除' do
      it 'tweetの個別ページからお気に入り登録/解除ができること', js: true do
        expect(page).to have_css('.img-inactive-heart')
        find('.img-inactive-heart').click
        expect(page).to have_css('.img-active-heart')
        find('.img-active-heart').click
        expect(page).to have_css('.img-inactive-heart')
      end
    end
  end

  describe 'お気に入り一覧ページ', js: true do
    let!(:tweet) { create(:tweet, user: user) }
    let!(:other_user) { create(:user) }
    let!(:other_tweet) { create(:tweet, user: other_user) }
    before do
      sign_in user
    end
    it '投稿にいいねしたりいいねを外すと、お気に入り一覧ページが期待通り表示されること' do
      visit favorites_path
      expect(page).to have_content 'お気に入りの投稿'
      tweet.likes.create(user_id: user.id)
      other_tweet.likes.create(user_id: user.id)
      visit favorites_path
      expect(page).to have_css '.card', count: 2
      expect(page).to have_content tweet.content
      expect(page).to have_content other_tweet.content
      like = other_tweet.likes.find_by(user_id: user.id)
      like.destroy!
      visit favorites_path
      expect(page).to have_css '.card', count: 1
      expect(page).to have_content tweet.content
    end
  end

  describe 'tweet/show/comment', js: true do
    context 'コメントの登録＆削除' do
      let!(:tweet) { create(:tweet, user: user) }
      before do
        sign_in user
      end
      it '自分のtweetに対するコメントの登録＆削除が正常に完了すること' do
        visit tweet_path(tweet)
        fill_in 'comment[content]', with: '頑張ろう'
        click_button 'コメントをする'
        within find('#comments_area') do
          expect(page).to have_css '.comment-container', count: 1
        end
        find('.comment-deletebtn').click
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_css '.comment-container', count: 1
      end
    end
    context '別ユーザーのコメントの削除' do
      let!(:other_user) { create(:user) }
      let!(:tweet) { create(:tweet, user: other_user) }
      let!(:comment) { create(:comment, tweet: tweet, user: other_user)}
      before do
        sign_in user
      end
      it '別ユーザーのtweetのコメントには削除リンクが無いこと' do
        visit tweet_path(tweet)
        expect(page).to have_css '.comment-container', count: 1
        expect(page).not_to have_css '.comment-deletebtn'
      end
    end
  end

  describe 'tweet/search' do
    context '検索機能' do
      context 'ログインしている場合' do
        before do
          sign_in user
          visit search_tweets_path
        end
        it 'ログイン後の検索ページに検索窓が表示されていること' do
          expect(page).to have_css '.form-control'
        end

        it 'フィードの中から検索ワードに該当する結果が表示されること' do
          create(:tweet, content: '辛い', user: user)
          fill_in 'q[content_cont]', with: '辛い'
          click_button '検索'
          expect(page).to have_css 'h3', text: '”辛い”の検索結果：1件'
          expect(page).to have_css '.card', count: 1

        end

        it '検索ワードを入れずに検索ボタンを押した場合、料理一覧が表示されること' do
          fill_in 'q[content_cont]', with: ''
          click_button '検索'
          expect(page).to have_css 'h3', text: '投稿一覧'
          expect(page).to have_css '.card', count: Tweet.count
        end
      end
    end
  end
end
