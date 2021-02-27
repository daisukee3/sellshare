require 'rails_helper'

RSpec.describe 'Tweet', type: :system do
  let!(:user) { create(:user) }
  let!(:tweets) { create_list(:tweet, 3,  user: user) }

  it 'tweet一覧が表示される' do
    visit root_path
    tweets.each do |tweet|
      expect(page).to have_css('.card_title', text: tweet.content.to_plain_text)
    end
  end

  it 'tweet詳細を表示できる' do
    visit root_path
    
    tweet = tweets.first
    click_on tweet.content.to_plain_text

    expect(page).to have_css('.tweet_content', text: tweet.content.to_plain_text)
  end
end