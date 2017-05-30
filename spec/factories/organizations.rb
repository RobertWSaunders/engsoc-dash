FactoryGirl.define do
  factory :organization do
    email         { Faker::Internet.email }
    name          { Faker::Team.name }
    description   { Faker::Lorem.paragraph(4, true) }
    department    "clubs"

    trait :invalid do
      department  nil
    end
  end
end
