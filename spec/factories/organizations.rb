FactoryGirl.define do

  factory :organization do
    email         { Faker::Internet.unique.email }
    name          { Faker::Team.unique.name }
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

    # never used in the current set of cases - because not sure 
    # how to assign the after created job to a variable for access...
    # factory :organization_with_regular_job do
    #   after(:create) do |organization|
    #     create(:job, role: "regular", organization: organization)
    #   end
    # end
  end

  factory :job do
    status        "active"
    job_type      "volunteer"
    title         { Faker::Job.title }
    description   { Faker::Lorem.paragraph(4, true) }

    trait :regular do
      role        "regular"
    end
    trait :management do
      role        "management"
    end
    trait :admin do
      role        "admin"
    end
  end

end
