require "faker"

FactoryBot.define do
  factory :user do
    provider { "google" }
    name             { Faker::FunnyName.name }
    uid              { SecureRandom.uuid }
    oauth_token      { SecureRandom.uuid }
    oauth_expires_at { Time.now + 1.day }
  end
end
