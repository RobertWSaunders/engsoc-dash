class JobPosting < ApplicationRecord
  belongs_to :job
  has_many :job_applications
  enum status: [ :open, :interviewing, :closed ]
end
