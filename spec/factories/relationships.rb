FactoryBot.define do
  factory :relationship do
    association :follower
    association :following
  end
end
