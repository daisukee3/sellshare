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
class Tweet < ApplicationRecord
  validates :content, presence: true
  validates :content, length: { maximum: 200 }
  validates :content, uniqueness: true

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :eyecatch

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  def like_count
    likes.count
  end
end
