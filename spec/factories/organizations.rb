FactoryGirl.define do
  factory :organization do
    email         { Faker::Internet.email }
    name          { Faker::Team.name }
    description   { Faker::Lorem.paragraph(4, true) }
    department    "clubs"

    trait :invalid do
      department  nil
    end

    trait :waiting_approval do
      status      "waiting_approval"
    end
    trait :active do
      status      "active"
    end
    trait :archived do
      status      "archived"
    end
  end
end
