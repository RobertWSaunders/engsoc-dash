User.create!(first_name:  "Peter",
             last_name:   "SuperAdmin",
             email:       "superadmin@example",
             password:    "password",
             role:        "superadmin")

User.create!(first_name:  "Peter",
             last_name:   "Admin",
             email:       "admin@example",
             password:    "password",
             role:        "admin")

User.create!(first_name:  "Peter",
             last_name:   "Manager",
             email:       "management@example",
             password:    "password",
             role:        "management")

User.create!(first_name:  "Peter",
             last_name:   "student",
             email:       "student@example",
             password:    "password",
             role:        0)

User.create!(first_name:  "Paisley",
             last_name:   "student2",
             email:       "student2@example",
             password:    "password",
             role:        0)

itteam = Organization.create!(name:         "EngSoc IT-Team",
                     email:        "it-team@engsoc.queensu.ca",
                     description:  "The secret service for all your needs")

itteam.jobs.create!(user_id: 3, title: "Team Manager", description: "The TM is responsible for managing")

30.times do |n|
  first_name  = Faker::Name.name
  last_name = Faker::Name.name
  email = "example-#{n+1}@user.org"
  password = "password"
  User.create!(first_name:    first_name,
               last_name:     last_name,
               email:         email,
               password:      password,
               role:          0)
end

99.times do |n|
  name = Faker::Company.name
  email = "example-#{n+1}@organization.org"
  desc = Faker::Lorem.paragraph(3, true)
  Organization.create!(
      name: name,
      email: email,
      description: desc)
end
