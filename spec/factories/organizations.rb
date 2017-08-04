FactoryGirl.define do

  factory :organization do
    email         { Faker::Internet.unique.email }
    name          { Faker::Team.unique.name + (((1..1000).to_a).sample).to_s }
    description   { Faker::Lorem.paragraph(4, true) }
    department    "clubs"

    trait :invalid do
      department  nil
    end

    # default
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
    # status defaults to waiting_approval...
    status        "active"
    job_type      "volunteer"
    title         { Faker::Job.title }
    description   { Faker::Lorem.paragraph(1, true) }

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

  factory :position do
    # provide job_id and user_id
    # default dates are as "active"
    start_date    { Time.now - 30.days }
    end_date      { Time.now + 200.days }
    
    trait :active do
      start_date    { Time.now - 30.days }
      end_date      { Time.now + 200.days }
    end
    trait :archived do
      start_date    { Time.now - 300.days }
      end_date      { Time.now - 100.days }
    end
    trait :upcoming do
      start_date    { Time.now + 30.days }
      end_date      { Time.now + 230.days }
    end

  end

  factory :job_posting do
    description    { Faker::Lorem.paragraph(1, true) }
    deadline       { Time.now + 30.days }
    title          { Faker::Job.title }
    start_date     { Time.now + 20.days }
    end_date       { Time.now + 220.days }

    # default
    trait :waiting_approval do
      status       "waiting_approval"
    end
    trait :draft do
      status       "draft"
    end
    trait :open do
      status       "open"
    end
    trait :interviewing do
      status       "interviewing"
    end
    trait :closed do
      status       "closed"
    end
    trait :extension_pending do
      status       "extension_pending"
    end
  end

end
