# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string           default(""), not null
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_account               (account) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user, aliases: [:follower, :following] do
    account { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    password { 'password' }

    trait :with_profile do
      after :build do |user|
        build(:profile, user: user)
      end
    end

    trait :admin do
      admin { true }
    end
  end
end
