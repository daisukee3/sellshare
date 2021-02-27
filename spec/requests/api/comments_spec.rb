require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:tweet) { create(:tweet, user: user) }
  let!(:comments) { create_list(:comment, 3, tweet: tweet) }

  describe 'GET /api/comments' do
    it '200 Status' do
      get api_comments_path(tweet_id: tweet.id)
      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['content']).to eq comments.first.content
      expect(body[1]['content']).to eq comments.second.content
      expect(body[2]['content']).to eq comments.third.content
      
    end
  end
end
