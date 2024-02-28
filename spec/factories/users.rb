FactoryBot.define do
  factory :user do
    first_name {"Test"}
    last_name {"User"}
    sequence :email do |n|
      "user#{n}@example.com"
    end
    
    password {"password"}
  end
end
