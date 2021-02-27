FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.characters(number: 250) }
  end
end