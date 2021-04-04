# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tweets_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let!(:user) { create(:user) }

  context '内容が入力されている場合' do
    let!(:tweet) { build(:tweet, user: user) }

    it 'tweetを保存できる' do
      expect(tweet).to be_valid

    end
  end

  context '内容が301文字の場合' do
    let!(:tweet) { build(:tweet, content: Faker::Lorem.characters(number: 301), user: user) }

    before do
      tweet.save
    end

    it 'tweetを保存できない' do
      expect(tweet.errors.messages[:content][0]).to eq('は300文字以内で入力してください')
    end
  end

  context '並び順' do
    let!(:tweet_yesterday) { create(:tweet, :yesterday, user: user) }
    let!(:tweet_one_week_ago) { create(:tweet, :one_week_ago, user: user) }
    let!(:tweet_one_month_ago) { create(:tweet, :one_month_ago, user: user) }
    it '最も最近の投稿が最初の投稿になっていること' do
      expect(tweet_yesterday).to eq Tweet.first
    end
  end
end
