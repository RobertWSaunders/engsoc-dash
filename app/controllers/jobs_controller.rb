class JobsController < ApplicationController

  load_and_authorize_resource

  before_action :set_job, only: [:show, :destroy, :edit, :update]

  def index
    @jobs = Job.paginate(:page => params[:page], :per_page => 5)
  end

  def show
  end

  def create
  end

  def update
  end


  def edit
  end

  private

  # define the jobs parameters
    def jobs_params
      params.require(:job).permit(:title, :user_id, :organization_id)
    end

    def set_job
      @job = Jobs.find(params[:id])
    end
end
