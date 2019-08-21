require "faker"

FactoryBot.define do
  factory :user do
    provider { "google" }
    name             { Faker::FunnyName.name }
    uid              { SecureRandom.uuid }
    oauth_token      { SecureRandom.uuid }
    oauth_expires_at { 1.day.from_now }
  end
end
