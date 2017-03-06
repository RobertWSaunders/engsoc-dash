class JobPostingQuestion < ApplicationRecord
  belongs_to :job_posting, :foreign_key => :job_posting_id
  has_many :job_posting_answers
  validates :content, presence: true, length: { minimum: 5 }
end
