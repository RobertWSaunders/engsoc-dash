
#create some users
#super admin
User.create!(first_name:  "Robert",
             last_name:   "Saunders",
             email:       "superadmin@example.com",
             password:    "password",
             role:        "superadmin")

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
              department: "services",
              status: "active")

Organization.create!(
              name: "Robogals",
              email: "robogals@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "clubs")

Organization.create!(
              name: "IT Team",
              email: "it.manager@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "information_technology",
              status: "active")

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
              department: "directors",
              status: "active")

Organization.create!(
              name: "Clark Hall Pub",
              email: "clarkhall@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "services",
              status: "active")

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

#####################
# QGEC seeds
org = Organization.create!(
              name: "Queen's Global Energy Conference",
              email: "qgec@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "conferences",
              status: "active")
user = User.create!(
             first_name:  "Katrina",
             last_name:   "Stirling",
             email:       "kat@queensu.ca",
             password:    "password",
             role:        "student")
Job.create!(
              title: "Chair",
              organization_id: org.id,
              user_id: user.id,
              status: "active",
              job_type: "volunteer",
              role: "management",
              description: Faker::Lorem.paragraph(4, true))
user = User.create!(
             first_name:  "Peter",
             last_name:   "Ju",
             email:       "pete@queensu.ca",
             password:    "password",
             role:        "student")
Job.create!(
              title: "Web & IT",
              organization_id: org.id,
              user_id: user.id,
              status: "active",
              job_type: "volunteer",
              role: "regular",
              description: Faker::Lorem.paragraph(4, true))
user = User.create!(
             first_name:  "Farhaj",
             last_name:   "Khan",
             email:       "farhaj@queensu.ca",
             password:    "password",
             role:        "student")
Job.create!(
              title: "Logistics & Finance",
              organization_id: org.id,
              user_id: user.id,
              status: "active",
              job_type: "volunteer",
              role: "regular",
              description: Faker::Lorem.paragraph(4, true))
user = User.create!(
             first_name:  "Graham",
             last_name:   "Girard",
             email:       "graham@queensu.ca",
             password:    "password",
             role:        "student")
Job.create!(
              title: "Head of Sponsorship",
              organization_id: org.id,
              user_id: user.id,
              status: "active",
              job_type: "volunteer",
              role: "regular",
              description: Faker::Lorem.paragraph(4, true))
Job.create!(
              title: "Head of Speakers",
              organization_id: org.id,
              # user_id: user.id,
              status: "active",
              job_type: "volunteer",
              role: "regular",
              description: Faker::Lorem.paragraph(4, true))
org = Organization.create!(
              name: "Automated Poker Team",
              email: "qapt@engsoc.queensu.ca",
              description: Faker::Lorem.paragraph(4, true),
              department: "clubs",
              status: "active")
Job.create!(
              title: "Captain",
              organization_id: org.id,
              status: "active",
              job_type: "volunteer",
              role: "management",
              description: Faker::Lorem.paragraph(4, true))
Job.create!(
              title: "Bot Programmer",
              organization_id: org.id,
              status: "active",
              job_type: "volunteer",
              role: "regular",
              description: Faker::Lorem.paragraph(4, true))
job = Job.create!(
              title: "Statistics Analyer",
              organization_id: org.id,
              status: "active",
              job_type: "volunteer",
              role: "regular",
              description: Faker::Lorem.paragraph(4, true))
