FactoryBot.define do
  factory :profile do
    introduction { Faker::Lorem.characters(number: 100) }
  end
end
