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