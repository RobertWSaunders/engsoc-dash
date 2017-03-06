class JobPostingAnswer < ApplicationRecord
  belongs_to :job_application, :foreign_key => :job_application_id
  belongs_to :job_posting_question
end
