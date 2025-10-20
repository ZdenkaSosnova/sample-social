FactoryBot.define do
  factory :poll do
    question { "What's your favorite color?" }
    association :user

    transient do
      options_count { 2 }  # default to 2 options
    end

    after(:build) do |poll, evaluator|
      # Build poll_options before poll is saved
      evaluator.options_count.times do
        poll.poll_options.build(option_text: Faker::Color.color_name)
      end
    end
  end
end