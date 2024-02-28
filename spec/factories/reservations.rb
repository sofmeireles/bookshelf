FactoryBot.define do
  factory :reservation do
    association :user
    association :book

    returned_on {nil}

    trait :returned do
      returned_on { Date.tomorrow }
    end
  end
end
