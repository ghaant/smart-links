FactoryBot.define do
  factory :user do
    name { 'Max Mustermann' }
    sequence(:email) { |n| "name#{n}@gmail.com" }
    password { 'blah-blah' }
  end
end
