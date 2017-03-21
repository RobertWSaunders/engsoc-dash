class JobPostingAnswersController < ApplicationController
  before_action :set_job_posting_answer, only: [:show, :edit, :update, :destroy]

  # GET /job_posting_answers
  # GET /job_posting_answers.json
  # def index
  #   @job_posting_answers = JobPostingAnswer.all
  # end

  # GET /job_posting_answers/1
  # GET /job_posting_answers/1.json
  def show
  end

  # GET /job_posting_answers/new
  def new
    @job_posting = JobPosting.find(params[:job_posting_id])
    @job_application = JobApplication.find(params[:job_application_id])
    @all_questions = @job_posting.job_posting_questions.all
    @page_answers = []
    @job_posting.job_posting_questions.count.times do
      @page_answers << JobPostingAnswer.new
    end
  end

  # GET /job_posting_answers/1/edit
  def edit
  end

  # POST /job_posting_answers
  # POST /job_posting_answers.json
  def create
    p params["answers"]
    params["answers"].each do |key, answer|
      # p answer
      @answer = JobPostingAnswer.create(answer_params(answer))
    end
    @job_application_id = @answer.job_application_id
    redirect_to finalize_job_application_path(:id => @job_application_id)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_posting_answer
      @job_posting = JobPosting.find(params[:job_posting_id])
      @job_application = @job_posting.job_applications.find(params[:job_application_id])
      @job_posting_answer = @job_application.job_posting_answers.find(params[:id])
    end

    def answer_params(my_params)
      my_params.permit(:content, :job_posting_questions_id, :job_application_id)
    end


end
