require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  let!(:user) { create(:user) }
  let!(:tweet) { create_list(:tweet, 5,  user: user) }

  describe 'GET /tweets' do
    it '200statusが返ってくる' do
      get tweets_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /tweets' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'tweetが保存される' do
        tweet_params = attributes_for(:tweet)
        post tweets_path({tweet: tweet_params})
        expect(response).to have_http_status(302)
        expect(Tweet.last.content.body.to_plain_text).to eq(tweet_params[:content])
      end
    end

    context 'ログインしていない場合' do
      it 'ログイン画面に遷移' do
        tweet_params = attributes_for(:tweet)
        post tweets_path({tweet: tweet_params})
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
