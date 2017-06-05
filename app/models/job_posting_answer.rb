class JobPostingAnswer < ApplicationRecord
  
  # necessary to ensure that the placeholder 
  # first job posting question (imperative) cannot be deleted
  # the first JPQ must be present due to the hardcoding of the first ID
  before_destroy :cannot_delete_generated

  #Relationships
  #a job application answer belongs to a job application
  belongs_to :job_application, :foreign_key => :job_application_id
  validates :job_application_id, :presence => true, :if => :not_generated?
  #a job application answer belongs to a question
  belongs_to :job_posting_question
  validates :job_posting_questions_id, :presence => true
  validates :content, :presence => true, length: { minimum: 3, maximum: 200 }, :if => :not_generated?

  private

    def cannot_delete_generated
      raise "Cannot delete the first, generated job posting question" if (id == 1)
    end

    # used to break some validation checks for the imperative jpq
    def not_generated?
      !(id == 1)
    end

end
