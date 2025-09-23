FactoryBot.define do
  factory :user do
    sequence(:name) { "User" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin do
      admin { true }
    end
  end
end