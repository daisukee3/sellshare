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
class Tweet < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 300 }

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :eyecatch
  has_rich_text :content

  has_many :notifications, dependent: :destroy

end
