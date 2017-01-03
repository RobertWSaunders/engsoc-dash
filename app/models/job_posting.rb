class JobPosting < ApplicationRecord
  belongs_to :job
  belongs_to :user, :foreign_key => :creator_id
  has_many :job_applications, dependent: :destroy
  enum status: [:waiting_approval, :draft, :open, :interviewing, :closed ]
  validates :job_id, presence: true
end
