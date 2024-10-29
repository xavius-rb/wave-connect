FactoryBot.define do
  factory :service do
    name { Faker::App.name }
    repository_url { Faker::Internet.url }
    repository_access_token { Faker::Internet.password }
  end
end
