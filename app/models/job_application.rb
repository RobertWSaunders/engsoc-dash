class JobApplication < ApplicationRecord
  belongs_to :job_posting
  belongs_to :user
  has_many :job_posting_answers
  enum status: [:draft, :submitted, :interview_scheduled, :hired, :not_chosen ]
end
