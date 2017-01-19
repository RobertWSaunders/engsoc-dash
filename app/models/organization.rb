class Organization < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :job_postings, :foreign_key => :organization_id
  enum type: [:unspecified, :engsoc, :conferences, :design_team]
end
