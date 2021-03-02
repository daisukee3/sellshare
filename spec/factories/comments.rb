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
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 250) }
  end
end
