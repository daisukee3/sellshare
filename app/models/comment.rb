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
class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  validates :content, presence: true
  validates :content, length: { maximum: 300 }

  has_many :notifications, dependent: :destroy
end
