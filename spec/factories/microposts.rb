FactoryBot.define do
  factory :micropost do
    content { "Lorem ipsum" }
    user { create(:user) }
    visibility { "followers_only" }
  end
end