FactoryBot.define do
  factory :reservation do
    association :user
    association :book

    trait :returned do
      returned_on { Date.tomorrow }
    end
  end
end
