class JobApplication < ApplicationRecord
  belongs_to :job_posting
  belongs_to :user
  enum status: [:draft, :submitted, :interview_scheduled, :hired, :not_chosen ]
end
