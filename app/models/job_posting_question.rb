class JobPostingQuestion < ApplicationRecord
  belongs_to :job_posting, :foreign_key => :job_posting_id
  validates :question, presence: true, length: { minimum: 5 }
end
