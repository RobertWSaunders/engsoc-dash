class JobApplication < ApplicationRecord

  #Relationships
  #a job application belongs to a job posting
  belongs_to :job_posting
  #a job application belongs to a user
  belongs_to :user
  #a job application has many job applications answers
  has_many :job_posting_answers, dependent: :destroy

  enum status: [:draft, :submitted, :interview_scheduled, :hired, :not_chosen ]

  accepts_nested_attributes_for :job_posting_answers

end
