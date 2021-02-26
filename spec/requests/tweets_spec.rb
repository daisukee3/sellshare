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
end
