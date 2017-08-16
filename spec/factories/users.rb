# https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
# Each factory has a name and a set of attributes.
# The name is used to guess the class of the object
# by default, but it's possible to explicitly specify it

FactoryGirl.define do
  factory :superadmin, class: User do
    first_name "Robert"
    last_name  "Saunders"
    email      "superadmin@example.com"
    password   "password"
    role       "superadmin"
  end

  factory :student, class: User do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.email }
    password   "password"
    role       "student"
  end

  factory :regular, class: User do
    first_name "Regular"
    last_name  "User"
    email      "regular@example.com"
    password   "password"
    role       "student"
  end
end
