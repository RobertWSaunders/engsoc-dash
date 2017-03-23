class JobApplicationsController < ApplicationController

  before_action :set_job_application, only: [:show, :edit, :update, :destroy, :finalize]

  # GET /job_postings/:job_posting_id/job_applications
  def index
    @job_posting = JobPosting.find(params[:job_posting_id])
    @job_applications = @job_posting.job_applications.all
  end

  # GET /job_postings/:job_posting_id/job_applications/new
  def new
    @job_posting = JobPosting.find(params[:job_posting_id])
    @existing = JobApplication.where(user_id: current_user.id, job_posting_id: params[:job_posting_id]).first
    if @existing
      if @existing.status == "submitted"
        flash[:notice] = "It seems like you have already applied for this job."
        redirect_to job_posting_path(@job_posting)
      else
        redirect_to edit_job_posting_job_application_job_posting_answer_path(:job_application_id => @existing.id, :id => 1)
      end
    end
    @job_application = JobApplication.new
  end

  # POST /job_postings/:job_posting_id/job_applications
  def create
    @job_application = JobApplication.new(job_application_params)
    @job_posting = JobPosting.find(params[:job_posting_id])
    if @job_application.save
      redirect_to new_job_posting_job_application_job_posting_answer_path(:job_application_id => @job_application.id)
    else
      render 'new'
    end
  end

  # GET /job_applications/:id
  def show
    @job_applications = JobApplication.where(job_posting_id: @job_application.job_posting_id).all
  end

  # GET /job_applications/:id/finalize
  def finalize
    @job_application = JobApplication.find(params[:id])
    @all_questions = @job_application.job_posting.job_posting_questions.all
    @job_posting_answers = JobPostingAnswer.where(:job_application_id => @job_application.id)
  end

  # PUT /job_applications/:id
  def update
    if @job_application.update_attributes(job_application_params)
      redirect_to root_path
    else
      render 'finalize'
    end
  end

  # DELETE /job_applications/:id
  def destroy
    @job_application.destroy
    redirect_to job_posting_job_applications_path
    respond_to do |format|
      format.html { redirect_to(job_posting_job_applications_path(@job_application.job_posting.id)) }
      format.json { head :no_content }
    end
  end

  # GET /job_applications/user
  def user
    @user_job_applications = JobApplication.where(user_id: current_user.id)
  end

  private

    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    def job_application_params
      params.require(:job_application).permit(:user_id, :job_posting_id, :status, job_posting_answers: [:id, :content])
    end

end
