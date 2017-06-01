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

    factory :organization_with_regular_job do
      after(:create) do |organization|
        create(:job, role: "regular", organization: organization)
      end
    end
  end

  factory :job do
    status        "active"
    role          "regular"
    job_type      "volunteer"
    title         { Faker::Job.title }
    description   { Faker::Lorem.paragraph(4, true) }
  end

end
