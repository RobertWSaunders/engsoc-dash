class JobApplicationsController < ApplicationController
  before_action :set_job_application, only: [:show, :edit, :update, :destroy]

  # GET /job_applications
  # GET /job_applications.json
  def index
    @job_posting = JobPosting.find(params[:job_posting_id])
    @job_applications = @job_posting.job_applications
  end

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
    @job_application = JobApplication.find(params[:id])
  end

  # GET /job_applications/new
  def new
    @job_application = JobApplication.new
    @job_posting = JobPosting.find(params[:job_posting_id])
    @job_application.job_application_answers.build
  end

  # GET /job_applications/1/edit
  # Don't think we'll be using edit...
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
  # PATCH/PUT /job_applications/1.json
  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to @job_application, notice: 'Job application was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_application }
      else
        format.html { render :edit }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_application_params
      params.require(:job_application).permit(:user_id, :job_posting_id, :status, job_posting_answers: [:id, :content])
    end
end
