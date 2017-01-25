class JobPosting < ApplicationRecord
  belongs_to :organization, :foreign_key => :organization_id
  belongs_to :user, :foreign_key => :creator_id
  has_many :job_applications, dependent: :destroy
  enum status: [:waiting_approval, :draft, :open, :interviews_pending, :interviews_scheduled, :closed ]
  validates :organization_id, presence: true
end
