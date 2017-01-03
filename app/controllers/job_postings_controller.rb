class JobPostingsController < ApplicationController

  before_action :set_job_posting, only: [:show, :destroy, :edit, :update]

  def index
    @jobpostings = JobPosting.paginate(:page => params[:page], :per_page => 5)
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
