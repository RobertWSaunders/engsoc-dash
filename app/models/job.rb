class Job < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :job_postings, dependent: :destroy
  enum job_type: [ :full_time, :part_time, :volunteer ]
end
