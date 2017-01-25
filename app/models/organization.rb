class Organization < ApplicationRecord
  has_many :jobs
  has_many :users, :through => :jobs
  has_many :job_postings, :foreign_key => :organization_id
  default_scope -> { order(name: :asc)}
  enum type: [:unspecified, :engsoc, :conferences, :design_team]
  validates :name, presence: true, length: { maximum: 50 }
  accepts_nested_attributes_for :jobs
end
