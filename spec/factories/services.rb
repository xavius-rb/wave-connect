FactoryBot.define do
  factory :service do
    name { Faker::App.name }
    repository_url { Faker::Internet.url }
  end
end
