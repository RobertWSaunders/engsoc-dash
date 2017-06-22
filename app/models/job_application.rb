class JobApplication < ApplicationRecord
  include Filterable
  scope :status, -> (status) { where status: status }

  #Relationships
  #a job application belongs to a job posting
  belongs_to :job_posting
  #a job application belongs to a user
  belongs_to :user
  has_one :resume, dependent: :nullify
  #a job application has many job applications answers
  has_many :job_posting_answers, dependent: :destroy

  has_one :interview

  enum status: [:draft, :submitted, :interview_scheduled, :hired, :declined ]

  accepts_nested_attributes_for :job_posting_answers

end
