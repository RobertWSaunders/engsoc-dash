class Job < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :job_postings, dependent: :destroy
end
