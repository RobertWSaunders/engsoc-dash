
#create some users
#super admin
User.create!(first_name:  "Robert",
             last_name:   "Saunders",
             email:       "superadmin@example.com",
             password:    "password",
             role:        "superadmin")

#admin
User.create!(first_name:  "Kaitlyn",
             last_name:   "Saunders",
             email:       "admin@example.com",
             password:    "password",
             role:        "admin")

#student
User.create!(first_name:  "Ashleigh",
             last_name:   "Saunders",
             email:       "student@example.com",
             password:    "password",
             role:        "student")
#hr example
User.create!(first_name:  "Rachel",
             last_name:   "McConnell",
             email:       "hr@engsoc.queensu.ca",
             password:    "password",
             role:        "student")

#manager example
User.create!(first_name:  "Carson",
             last_name:   "Cook",
             email:       "it.manager@engsoc.queensu.ca",
             password:    "password",
             role:        "student")

#make some organizations
Organization.create!(
              name: "Queen's Conference on Business Technology",
              email: "qcbt@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "conferences")

Organization.create!(
              name: "Queen's Global Innovation Conference",
              email: "qgic@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "conferences")

Organization.create!(
              name: "EngLinks",
              email: "englinks@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "services")

Organization.create!(
              name: "Science Quest",
              email: "sciencequest@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "services")

Organization.create!(
              name: "Campus Equipment Outfitters",
              email: "ceo@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "services")

Organization.create!(
              name: "Robogals",
              email: "robogals@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "clubs")

Organization.create!(
              name: "IT Team",
              email: "it.manager@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "information_technology")

Organization.create!(
              name: "Fix N' Clean",
              email: "fixnclean@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "community_outreach")

Organization.create!(
              name: "FREC Committee",
              email: "fc@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "orientation_week")

Organization.create!(
              name: "Movember",
              email: "movember@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "events")

Organization.create!(
              name: "Engineering Society Executive and Director Team",
              email: "president@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "directors")

Organization.create!(
              name: "Clark Hall Pub",
              email: "clarkhall@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "services")

#create some more regular users
30.times do |n|
  first_name  = Faker::Name.name
  last_name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(first_name:    first_name,
               last_name:     last_name,
               email:         email,
               gender:        1,
               password:      password,
               role:          0)
end
