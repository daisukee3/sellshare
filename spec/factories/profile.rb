FactoryBot.define do
  factory :profile do
    introduction { Faker::Lorem.characters(number: 300) }
    gender { Profile.genders.keys.sample }
    age { Profile.ages.keys.sample }
    type { Profile.types.keys.sample }
  end
end
