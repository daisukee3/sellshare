FactoryBot.define do
  factory :user do
    account { Faker::Lorem.characters(number: 5) }
    email { Faker::Internet.email }
    password { 'password' }
  end
end