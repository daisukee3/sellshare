# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
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
end
