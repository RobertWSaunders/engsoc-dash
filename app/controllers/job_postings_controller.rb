class JobPostingsController < ApplicationController

  load_and_authorize_resource

  skip_authorize_resource :only => [:filter_index, :filter, :filter_manage]

  # before any action gets fired set the job posting
  before_action :set_job_posting, only: [:show, :destroy, :edit, :update, :approve, :withdraw, :interview, :close, :reopen]

  # define the helper for the controller
  helper :application

  # GET /job_postings
  def index
    @active_org_jobs = Job.joins(:organization).where(organizations: {status: "active"})
    @open_job_postings = JobPosting.joins(:job).where(status: "open", jobs: { id: @active_org_jobs.ids}).filter(params.slice(:job_type, :job_department)).order(:deadline).paginate(:page => params[:page], :per_page => 10)
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
    #only show the job postings the user can manage
    if current_user.superadmin? || current_user.jobs.any? { |job| job.user_id == current_user.id && job.role == "admin" }
      @jobs_without_postings = Job.includes(:job_posting).where(job_postings: { job_id: nil })
    else
      @jobs_without_postings = Job.includes(:job_posting).where(organization_id: Organization.joins(:jobs).where(jobs: { user_id: current_user.id })).where(job_postings: { job_id: nil })
    end
    @vacant_jobs = @jobs_without_postings.includes(:positions).where(positions: { :user_id => nil})
    # TODO: include closed job postings to be reopened
  end

  # POST /job_posting
  def create
    @jobposting = JobPosting.new(job_posting_params)
    if @jobposting.save
      flash[:success] = "Job Posting Successfully Created!"
      redirect_to job_posting_job_posting_questions_path(@jobposting.id)
    else
      flash[:danger] = "Could not create Job Posting <ul>"
      flash[:danger] << "<li>" + @jobposting.errors.full_messages.join('</li><li>')
      flash[:danger] << "</ul>"
      # render :new
      redirect_to :action => "new", :job_id => @jobposting.job_id
    end
  end

  # GET /job_postings/:id
  def show
    if @job_posting.job.organization.status != "active" && current_user.role != ( "superadmin" || "management" )
      flash[:warning] = "The organization " + @job_posting.job.organization.name + " is not active, so its job postings cannot be viewed."
      redirect_back(fallback_location: job_postings_path)
    else
      if @job_posting.status == "open" || current_user.role == ( "superadmin" || "management" )
        @job = Job.find_by! id: @jobposting.job_id
        @organization = Organization.find_by! id: @job.organization_id
      else
        flash[:warning] = "Job posting " + @job_posting.title + " is currently not open."
        redirect_back(fallback_location: job_postings_path)
      end
    end
  end

  # GET /job_postings/:id/edit
  def edit
    @jobposting = JobPosting.find(params[:id])
  end

  # PUT /job_postings/:id
  def update
    @jobposting = JobPosting.find(params[:id])
    if @jobposting.status != "waiting_approval"
      flash[:danger] = "The Job Posting is currently not 'waiting approval', so cannot be created, deleted, or editted. Please contact an administrator if you require assistance."
      redirect_back(fallback_location: job_postings_path)
    else
      if @jobposting.update_attributes(job_posting_params)
        flash[:success] = "Job Posting Successfully Updated!"
        redirect_to job_posting_job_posting_questions_path(@jobposting.id)
      else
        flash[:danger] = "Could Not Update Job Posting!"
        flash[:danger] << "<li>" + @jobposting.errors.full_messages.join('</li><li>')
        flash[:danger] << "</ul>"
        redirect_to edit_job_posting_path(@jobposting)
      end
    end
  end

  # DESTROY /job_postings/:id
  def destroy
    @jobposting.destroy
    flash[:success] = "Job Posting Successfully Deleted!"
    redirect_to job_postings_path
  end

  # GET /job_postings/admin
  def admin
    @job_postings = JobPosting.filter(params.slice(:status)).order(:deadline).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /job_postings/:id/approve
  def approve
    @jobposting.status = "open"
    @jobposting.save
    redirect_back(fallback_location: job_postings_path)
  end

  # GET /job_postings/:id/withdraw
  def withdraw
    @jobposting.status = "waiting_approval"
    @jobposting.save
    redirect_back(fallback_location: job_postings_path)
  end

  # GET /job_postings/:id/interview
  def interview
    if @jobposting.deadline.past?
      @jobposting.status = "interviewing"
      @jobposting.save
      redirect_back(fallback_location: job_postings_path)
    else
      flash[:danger] = "Cannot begin interviewing process, job posting deadline has not passed."
      redirect_back(fallback_location: job_postings_path)
    end
  end

  # GET /job_postings/:id/close
  def close
    flash[:success] = "Job Posting Successfully Closed"
    @jobposting.status = "closed"
    # hired = @jobposting.job_applications.where({ status: "hired"})
    # job_application get #hire sets all hired job_application user_ids to job already

    # everyone else, decline
    not_hired = @jobposting.job_applications.where.not({ status: "hired"})
    not_hired.update_all status: "declined"
    # maybe set the previous job applications to be archived when the job_posting is reopened
    # @jobposting.job_applications.update_all archived: true
    @jobposting.save
    redirect_to job_posting_job_applications_path(:job_posting_id => @job_posting.id)
  end

  # GET /job_postings/:id/reopen
  def reopen
    flash[:success] = "Job Posting Successfully Reopened, Now Waiting for Admin Approval"
    @jobposting.status = "waiting_approval"
    @jobposting.job_applications.update_all archived: true
    @jobposting.save
    redirect_to job_posting_job_applications_path(:job_posting_id => @job_posting.id)
  end

  # GET /job_postings/manage
  def manage
    @managing_jobs = Job.includes(:positions).where(positions: { :user_id => current_user.id })
    @managed_orgs = Organization.includes(:jobs).where(jobs: { :id => @managing_jobs.ids, :role => ["management", "admin"] })
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
      params.require(:job_posting).permit(:creator_id, :title, :description, :job_id, :deadline, :status, :start_date, :end_date)
    end

    def set_job_posting
      @jobposting = JobPosting.find(params[:id])
    end
end
