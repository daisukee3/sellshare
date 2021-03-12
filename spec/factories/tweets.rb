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
FactoryBot.define do
  factory :tweet do
    content { Faker::Lorem.characters(number: 250) }
  end
end
