FactoryBot.define do
  factory :stage_environment do
    service
    name { Faker::Lorem.word }
  end
end
