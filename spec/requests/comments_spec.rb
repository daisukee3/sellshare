require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:tweet) { create(:tweet, user: user) }
  let!(:comment) { create(:comment, tweet: tweet, user: user) }

  context 'コメントの登録' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end
      it 'Ajaxで有効な内容のコメントが登録できること' do
        expect {
          post tweet_comments_path(tweet), xhr: true, params: { comment: { content: '頑張ろう' } }
        }.to change(tweet.comments, :count).by(1)
      end

      it 'Ajaxで無効な内容のコメントが登録できないこと' do
        expect {
          post tweet_comments_path(tweet), xhr: true, params: { comment: { content: '' } }
        }.not_to change(tweet.comments, :count)
      end
    end

    context 'ログインしていない場合' do
      it 'Ajaxでコメントは登録できない' do
        expect {
          post tweet_comments_path(tweet), xhr: true, params: { comment: { content: '頑張ろう'} }
        }.not_to change(tweet.comments, :count)
      end
    end
  end

  context 'コメントの削除' do
    context 'ログインしている場合' do
      context 'コメントを作成したユーザーである場合' do
        before do
          sign_in user
        end
        it 'Ajaxでコメントの削除ができること' do
          expect {
            delete tweet_comment_path(tweet, comment), xhr: true
          }.to change(tweet.comments, :count).by(-1)
        end
      end
        context 'コメントを作成したユーザーでない場合' do
          before do
            sign_in other_user
          end
          it 'Ajaxでコメントの削除はできないこと' do
            expect {
              delete tweet_comment_path(tweet, comment), xhr: true}
              .not_to change(tweet.comments, :count)
          end
        end
    end

    context 'ログインしていない場合' do
      it 'Ajaxでコメントの削除はできない' do
        expect {
          delete tweet_comment_path(tweet, comment), xhr: true
        }.not_to change(tweet.comments, :count)
      end
    end
  end
end
