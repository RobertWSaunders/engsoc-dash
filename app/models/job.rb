class Job < ApplicationRecord

  #Relationships
  #a job belongs to an organization
  belongs_to :organization
  #a job job belongs to a user
  belongs_to :user

  has_many :job_postings, :foreign_key => :job_id, dependent: :destroy


  #Validations
  #make sure the organization id is present
  validates :organization_id, presence: true
  #make sure the user id is present and unique
  # validates :user_id, presence: true, :uniqueness => { :scope => :organization_id }
  #make sure the title is present
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 15, maximum: 2000 }

  # organizations model has the same status enum
  enum status: [:waiting_approval, :active, :archived]

  accepts_nested_attributes_for :user, :organization
  
end
