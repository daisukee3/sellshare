# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tweet_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_tweet_id  (tweet_id)
#  index_comments_on_user_id   (user_id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:tweet) { create(:tweet, user: user) }
  let!(:comment) { create(:comment, tweet: tweet, user: user) }

  context 'バリデーション' do
    it '有効な状態であること' do
      expect(comment).to be_valid
    end

    it 'user_idがなければ無効な状態であること' do
      comment = build(:comment, user_id: nil)
      expect(comment).not_to be_valid
    end

    it 'tweet_idがなければ無効な状態であること' do
      comment = build(:comment, tweet_id: nil)
      expect(comment).not_to be_valid
    end

    it '内容がなければ無効な状態であること' do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
    end

    it '内容が300文字以内であること' do
      comment = build(:comment, content: 'a' * 301)
      comment.valid?
      expect(comment.errors[:content]).to include('は300文字以内で入力してください')
    end
  end
end
