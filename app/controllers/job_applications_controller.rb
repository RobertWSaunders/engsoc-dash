class JobApplicationsController < ApplicationController

  before_action :set_job_application, only: [:index, :show, :edit, :update, :destroy, :finalize]

  # GET /job_applications
  # GET /job_applications.json
  def index
  end

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
  end

  # GET /job_applications/new
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

  # GET /job_applications/1/edit
  def edit
  end

  # POST /job_applications
  # POST /job_applications.json
  def create
    @job_application = JobApplication.new(job_application_params)
    @job_posting = JobPosting.find(params[:job_posting_id])

    if @job_application.save
      redirect_to new_job_posting_job_application_job_posting_answer_path(:job_application_id => @job_application.id)
      # job_posting_job_applications_path(@job_posting.id)
    else
      render 'new'
    end
  end

  # PATCH/PUT /job_applications/1
  def update
    if @job_application.update_attributes(job_application_params)
      redirect_to root_path
    else
      render 'finalize'
    end
  end

  # DELETE /job_applications/1
  # DELETE /job_applications/1.json
  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to(job_posting_job_applications_path(@job_application.job_posting.id)) }
      format.json { head :no_content }
    end
  end

  def finalize
    @job_application = JobApplication.find(params[:id])
    @all_questions = @job_application.job_posting.job_posting_questions.all
    @job_posting_answers = JobPostingAnswer.where(:job_application_id => @job_application.id)
  end

  def user_job_applications
    @user_job_applications = JobApplication.where(user_id: current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      if params[:id].present?
        @job_application = JobApplication.find(params[:id])
      end
      if params[:job_posting_id].present?
        @job_posting = JobPosting.find(params[:job_posting_id])
        @job_applications = @job_posting.job_applications
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_application_params
      params.require(:job_application).permit(:user_id, :job_posting_id, :status, job_posting_answers: [:id, :content])
    end
end
