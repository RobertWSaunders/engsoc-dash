class JobPostingAnswersController < ApplicationController

  # TODO: write a check to for no params created - in case there are no job questions associated with the job posting!

  load_and_authorize_resource

  before_action :set_job_application, only: [:edit, :destroy]
  before_action :clear_cache, only: [:new]

  # GET /job_posting/:job_posting_id/job_application/:job_application_id/job_posting_answers/new
  def new
    @job_posting = JobPosting.find(params[:job_posting_id])
    @job_application = JobApplication.find(params[:job_application_id])
    if @job_application.job_posting_answers.any?
      redirect_to edit_job_application_job_posting_answer_path(:id => 1)
    end
    @all_questions = @job_posting.job_posting_questions.all
    @page_answers = []
    @job_posting.job_posting_questions.count.times do
      @page_answers << JobPostingAnswer.new
    end
  end

  # POST /job_posting/:job_posting_id/job_application/:job_application_id/job_posting_answers
  def create
    params["answers"].each do |key, answer|
      @answer = JobPostingAnswer.create(answer_params(answer))
    end
    @job_application_id = @answer.job_application_id
    redirect_to finalize_job_application_path(:id => @job_application_id)
  end

  # GET /job_applications/:job_application_id/job_posting_answers/:id/edit
  def edit
    @job_posting_answers = JobPostingAnswer.where(:job_application_id => @job_application.id).all
  end

  # PUT /job_applications/:job_application_id/job_posting_answers/:id
  def update
    params["answers"].each do |key, answer|
      # p answer[:id]
      @answer = JobPostingAnswer.find(answer[:id])
      @answer.update_attributes(answer_params(answer))
    end
    @job_application_id = @answer.job_application_id
    redirect_to finalize_job_application_path(:id => @job_application_id)
  end

  private
    def set_job_application
      @job_application = JobApplication.find(params[:job_application_id])
    end

    def answer_params(my_params)
      my_params.permit(:content, :job_posting_questions_id, :job_application_id, :id)
    end

    def clear_cache
      response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

end
