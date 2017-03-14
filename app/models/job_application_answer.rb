class JobApplicationAnswer < ApplicationRecord

  #Relationships
  belongs_to :job_application, :foreign_key => :job_application_id
  #a job application answer belongs to a question
  belongs_to :job_posting_question

end
