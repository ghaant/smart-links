FactoryBot.define do
  factory :smartlink do
    sequence(:slug) { |n| "some_slug_#{n}" }
    association :user
  end
end
