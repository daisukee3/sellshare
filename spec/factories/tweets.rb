FactoryBot.define do
  factory :tweet do
    content { Faker::Lorem.characters(number: 250) }
  end
end