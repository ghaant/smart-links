FactoryBot.define do
  factory :redirection do
    url { 'https://www.youtube.com/' }
    association :smartlink
    association :language
  end
end
