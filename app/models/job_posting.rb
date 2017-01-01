class JobPosting < ApplicationRecord
  belongs_to :job
  has_many :job_applications, dependent: :destroy
  enum status: [ :open, :interviewing, :closed ]
end
