class User < ApplicationRecord

  #Relationships
  #a user can have many jobs
  has_many :jobs, dependent: :destroy
  #a user can be part of many organizations
  has_many :organizations, :through => :jobs
  #a user can have many job applications, delete applications if user is deleted
  has_many :job_applications, dependent: :destroy
  #a user can have many job postings, given permission levels
  has_many :job_postings, :foreign_key => :creator_id

  #the roles a user can be associated with
  enum role: [:student, :management, :admin, :superadmin]

  #devise authentication system
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  accepts_nested_attributes_for :jobs

end
