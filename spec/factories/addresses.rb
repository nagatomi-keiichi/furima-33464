FactoryBot.define do
  factory :address do
    association :item
    association :user
  end
end
