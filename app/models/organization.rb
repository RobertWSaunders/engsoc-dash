class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :job_postings, :foreign_key => :organization_id
  default_scope -> { order(name: :asc)}
  enum type: [:unspecified, :engsoc, :conferences, :design_team]
  validates :name, presence: true, length: { maximum: 50 }
end
