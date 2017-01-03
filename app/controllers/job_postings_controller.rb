class JobPostingsController < ApplicationController

  before_action :set_job_posting, only: [:show, :destroy, :edit, :update]

  def index
    # retrieve only the
    @open_job_postings = JobPosting.where(status: 1).order(:deadline).paginate(:page => params[:page], :per_page => 5)
    @approval_job_postings = JobPosting.where(status: 0)
    @interviewing_job_postings = JobPosting.where(status: 2).order(:deadline)
    @closed_job_postings = JobPosting.where(status: 3).order(:deadline)
  end

  def show
  end

  private

  # define the jpbs parameters
    def job_postings_params
      params.require(:job_posting).permit(:status, :description)
    end

    def set_job_posting
      @jobposting = JobPosting.find(params[:id])
    end
end
