class JobPostingsController < ApplicationController

  # before any action gets fired set the job posting
  before_action :set_job_posting, only: [:show, :destroy, :edit, :update, :approve, :withdraw, :interview]

  # define the helper for the controller
  helper :application

  # GET /job_postings
  def index
    @open_job_postings = JobPosting.where(status: "open").filter(params.slice(:job_type, :job_department)).order(:deadline).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /job_postings/new?job_id=:id
  def new
    @jobposting = JobPosting.new
    if params[:job_id]
      @job = Job.find(params[:job_id])
    else
      redirect_to select_job_postings_path
    end
  end
  # Redirected from /job_postings/new if job_id unspecified
  # GET /job_postings/select
  def select
    @jobs_without_postings = Job.includes(:job_postings).where(job_postings: { job_id: nil })
    @vacant_jobs = @jobs_without_postings.where(:user_id => nil)
  end

  # POST /job_posting
  def create
    @jobposting = JobPosting.new(job_posting_params)
    if @jobposting.save
      redirect_to job_posting_job_posting_questions_path(@jobposting.id)
    else
      render 'new'
    end
  end

  # GET /job_postings/:id
  def show
    @job = Job.find_by! id: @jobposting.job_id
    @organization = Organization.find_by! id: @job.organization_id
  end

  # GET /job_postings/:id/edit
  def edit
    @jobposting = JobPosting.find(params[:id])
  end

  # PUT /job_postings/:id
  def update
    @jobposting = JobPosting.find(params[:id])
    if @jobposting.update_attributes(job_posting_params)
      redirect_to job_posting_job_posting_questions_path(@jobposting.id)
    else
      render 'edit'
    end
  end

  # DESTROY /job_postings/:id
  def destroy
    @jobposting.destroy
    redirect_to job_postings_path
  end

  # GET /job_postings/admin
  def admin
    @job_postings = JobPosting.filter(params.slice(:status)).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /job_postings/:id/approve
  def approve
    @jobposting.status = "open"
    @jobposting.save
    redirect_to job_postings_path
  end

  # GET /job_postings/:id/withdraw
  def withdraw
    @jobposting.status = "waiting_approval"
    @jobposting.save
    redirect_to job_postings_path
  end

  # GET /job_postings/:id/interview
  def interview
    p @jobposting
    @jobposting.status = "interviewing"
    @jobposting.save
    redirect_to job_postings_path
  end

  # GET /job_postings/manage
  def manage
    @managed_orgs = Organization.includes(:jobs).where(jobs: { :user_id => current_user.id, :role => ["management", "admin"] })
    @managed_jobs = Job.where(:organization_id => @managed_orgs.ids)
    @managed_postings = JobPosting.where(:job_id => @managed_jobs.ids).filter(params.slice(:status)).order("deadline").paginate(:page => params[:page], :per_page => 10)
  end

  def filter_index
    if params[:job_type] == "All" && params[:job_department] == "All"
      redirect_to job_postings_path
    elsif params[:job_type] != "All" && params[:job_department] == "All"
      redirect_to job_postings_path(job_type: params[:job_type])
    elsif params[:job_type] == "All" && params[:job_department] != "All"
      redirect_to job_postings_path(job_department: params[:job_department])
    else
      redirect_to job_postings_path(job_type: params[:job_type], job_department: params[:job_department])
    end
  end

  def filter
    if params[:status] == "All"
      redirect_to admin_job_postings_path
    else
      redirect_to admin_job_postings_path(status: params[:status])
    end
  end

  def filter_manage
    if params[:status] == "All"
      redirect_to manage_job_postings_path
    else
      redirect_to manage_job_postings_path(status: params[:status])
    end
  end

  private

    def job_posting_params
      params.require(:job_posting).permit(:creator_id, :title, :description, :job_id, :deadline, :status, :job_type)
    end

    def set_job_posting
      @jobposting = JobPosting.find(params[:id])
    end
end
