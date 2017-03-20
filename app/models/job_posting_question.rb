class JobPostingQuestion < ApplicationRecord

  #Relationships
  #a job posting question belongs to a job posting
  belongs_to :job_posting, :foreign_key => :job_posting_id
  #a job posting question has many job posting answers
  has_many :job_application_answers, :foreign_key => :job_posting_question_id

  #Validations
  #make sure the question is present and set bound
  validates :content, presence: true, length: { minimum: 5 }

end
