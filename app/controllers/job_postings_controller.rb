class JobPostingsController < ApplicationController

  # before any action gets fired set the job posting
  before_action :set_job_posting, only: [:show, :destroy, :edit, :update, :approve, :withdraw]

  # define the helper for the controller
  helper :application

  def index
    @open_job_postings = JobPosting.where(status: "open").order(:deadline).paginate(:page => params[:page], :per_page => 5)
  end

  def manage
    @approval_job_postings = JobPosting.where(status: "waiting_approval")
    @open_job_postings = JobPosting.where(status: "open").order(:deadline)
    @interviews_pending_job_postings = JobPosting.where(status: "interviews_pending").order(:deadline)
    @interviews_scheduled_job_postings = JobPosting.where(status: "interviews_scheduled").order(:deadline)
    @closed_job_postings = JobPosting.where(status: "closed").order(:deadline)
  end

  def show
    @job = Job.find_by! id: @jobposting.job_id
    @organization = Organization.find_by! id: @job.organization_id
  end

  def create
    @jobposting = JobPosting.new(job_posting_params)
    if @jobposting.save
      redirect_to job_posting_job_posting_questions_path(@jobposting.id)
      # redirect_to controller: 'job_postings', action: 'show', id: @job.organization.id
    else
      render 'new'
    end
  end

  def new
    @jobposting = JobPosting.new
    if params[:job_id]
      @job = Job.find(params[:job_id])
    else
      redirect_to select_job_path
    end
  end

  def select
    @vacant_jobs = Job.where(:user_id => nil)
  end

  def update
    @jobposting = JobPosting.find(params[:id])
    if @jobposting.update_attributes(job_posting_params)
      redirect_to job_posting_job_posting_questions_path(@jobposting.id)
    else
      render 'edit'
    end
  end

  def edit
    @jobposting = JobPosting.find(params[:id])
  end

  def destroy
    jobposting = JobPosting.find(params[:id]).destroy
    redirect_to job_postings_url
  end

  def approve
    @jobposting.status = "open"
    @jobposting.save
    redirect_to job_postings_path
  end

  def withdraw
    @jobposting.status = "waiting_approval"
    @jobposting.save
    redirect_to job_postings_path
  end

  private

  # define the jpbs parameters
    def job_posting_params
      params.require(:job_posting).permit(:creator_id, :title, :description, :job_id, :deadline, :status)
    end

    def set_job_posting
      @jobposting = JobPosting.find(params[:id])
    end
end
