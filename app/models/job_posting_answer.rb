class JobPostingAnswer < ApplicationRecord
  
  # necessary to ensure that the placeholder 
  # first job posting question (imperative) cannot be deleted
  # the first JPQ must be present due to the hardcoding of the first ID
  before_destroy :cannot_delete_generated

  #Relationships
  #a job application answer belongs to a job application
  belongs_to :job_application, :foreign_key => :job_application_id
  validates :job_application_id, :presence => true
  #a job application answer belongs to a question
  belongs_to :job_posting_question
  validates :job_posting_questions_id, :presence => true
  validates :content, :presence => true, length: { minimum: 3, maximum: 200 }

end
