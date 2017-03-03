class JobPostingQuestionsController < ApplicationController

  # before any action gets fired set the job posting
  before_action :set_job_posting_questions

  def index
    @jobpostingquestion = JobPostingQuestion.new
  end

  def create
    @jobpostingquestion = JobPostingQuestion.new(job_posting_question_params)
    if @jobpostingquestion.save
      redirect_to job_posting_job_posting_questions_path
    else
      render 'index'
    end
  end

  private

    def job_posting_question_params
      params.require(:job_posting_question).permit(:content, :job_posting_id)
    end

    def set_job_posting_questions
      @jobposting = JobPosting.find(params[:job_posting_id])
      @questions = @jobposting.job_posting_questions.all
    end

end
