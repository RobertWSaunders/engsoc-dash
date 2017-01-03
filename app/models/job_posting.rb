class JobPosting < ApplicationRecord
  belongs_to :job
  has_many :job_applications, dependent: :destroy
  enum status: [:awaiting_approval, :open, :interviewing, :closed ]
  validates :job_id, presence: true
end
