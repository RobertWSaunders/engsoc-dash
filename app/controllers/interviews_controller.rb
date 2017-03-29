class InterviewsController < ApplicationController
  before_action :set_interview, only: [:show, :edit, :update, :destroy]

  # GET /interviews
  # GET /interviews.json
  def index
    @interviews = Interview.all
  end

  # GET /interviews/new
  def new
    @interview = Interview.new
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

    respond_to do |format|
      if @interview.save
        format.html { redirect_to @interview, notice: 'Interview was successfully created.' }
      else
        format.html { render :new }
      end
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
    @interviews = Interview.all
    @managed_orgs = Organization.includes(:jobs).where(jobs: { :user_id => current_user.id, :role => ["management", "admin"] })
    @managed_jobs = Job.where(:organization_id => @managed_orgs.ids)
    @intervewing_postings = JobPosting.where(:job_id => @managed_jobs.ids, :status => "intervewing").order("deadline").paginate(:page => params[:page], :per_page => 10)  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interview
      @interview = Interview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interview_params
      params.require(:interview).permit(:job_posting_id, :start_time, :end_time)
    end
end
