class InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  # GET /interviews
  # GET /interviews.json
  def index
    @interviews = Interview.all
  end

  # GET /job_applications/:job_application_id/interviews/new
  def new
    @job_application = JobApplication.find(params[:job_application_id])
    if @job_application.interview.present?
      redirect_to manage_interviews_path, :alert => "This application already has a scheduled interview"
    else
      @job_posting = JobPosting.find(@job_application.job_posting_id)
      @interview = Interview.new
    end
  end

  # GET /interviews/1
  # GET /interviews/1.json
  def show
  end

  # GET /interviews/1/edit
  def edit
  end

  # POST /interviews
  def create
    @interview = Interview.new(interview_params)

    if @interview.save
      redirect_to manage_interviews_path
    else
      render :new
    end
  end

  # PATCH/PUT /interviews/1
  def update
    respond_to do |format|
      if @interview.update(interview_params)
        format.html { redirect_to @interview, notice: 'Interview was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /interviews/1
  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to interviews_url, notice: 'Interview was successfully destroyed.' }
    end
  end

  # GET /interviews/manage
  def manage
    @interviews = Interview.all.order(end_time: :asc)
    @managed_orgs = Organization.includes(:jobs).where(jobs: { :user_id => current_user.id, :role => ["management", "admin"] })
    @managed_jobs = Job.where(:organization_id => @managed_orgs.ids)
    @interviewing_postings = JobPosting.where(:job_id => @managed_jobs.ids, :status => "interviewing").order("deadline").paginate(:page => params[:page], :per_page => 10)  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:job_application_id, :start_time, :end_time)
    end
end
