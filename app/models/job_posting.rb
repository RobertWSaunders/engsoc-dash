class JobPosting < ApplicationRecord
  belongs_to :job
  has_many :job_applications, dependent: :destroy
  enum status: [:waiting_approval, :draft, :open, :interviewing, :closed ]
  validates :job_id, presence: true
end
