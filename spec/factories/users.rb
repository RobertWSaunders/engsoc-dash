FactoryGirl.define do
  factory :superuser, class: User do
    first_name "Super"
    last_name  "User"
    email      "superuser@example.com"
    password   "password"
    role       1
  end

  factory :student, class: User do
    first_name "Regular"
    last_name  "User"
    email      "regular@example.com"
    password   "password"
    role       0
  end
end