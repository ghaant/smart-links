FactoryBot.define do
  factory :language do
    sequence(:code) { |n| "l#{n}" }
    default { false }
  end
end
