class JobPosting < ApplicationRecord

  scope :status, -> (status) { where status: status }

  #Relationships
  #a job posting belongs to a job
  belongs_to :job, :foreign_key => :job_id, dependent: :destroy
  #a job posting belongs to a user
  belongs_to :user, :foreign_key => :creator_id

  #delete job applications if the related job posting is deleted
  has_many :job_applications, dependent: :destroy
  #delete job posting questions if the related job posting is deleted
  has_many :job_posting_questions, dependent: :destroy

  #different statuses for a job posting
  enum status: [:waiting_approval, :draft, :open, :interviews_pending, :interviews_scheduled, :closed, :extension_pending]

  #Validations
  #make sure a job_id is present
  validates :job_id, presence: true
  #title must be minimum length of five characters
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  #description must be at least fifteen characters
  validates :description, presence: true, length: { minimum: 15, maximum: 2000 }

end
