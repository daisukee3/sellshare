require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  describe 'GET /tweets' do
    it "200statusが返ってくる" do
      get tweets_path
      expect(response).to have_http_status(200)
    end
  end
end
