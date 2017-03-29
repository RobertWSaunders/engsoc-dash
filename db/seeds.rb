
User.create!(first_name:  "Robert",
             last_name:   "Saunders (Super Admin)",
             email:       "superadmin@example.com",
             password:    "password",
             role:        "superadmin")

User.create!(first_name:  "Robert",
             last_name:   "Saunders (Admin)",
             email:       "admin@example.com",
             password:    "password",
             role:        "admin")

30.times do |n|
  first_name  = Faker::Name.name
  last_name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(first_name:    first_name,
               last_name:     last_name,
               email:         email,
               password:      password,
               role:          0)
end

20.times do |n|
  name = Faker::Company.name
  email = Faker::Internet.email
  desc = Faker::Lorem.paragraph(4, true)
  Organization.create!(
      name: name,
      email: email,
      description: desc,
      department: 0)
end
