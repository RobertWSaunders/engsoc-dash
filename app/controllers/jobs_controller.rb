class JobsController < ApplicationController

  load_and_authorize_resource

  def index
    @jobs = Job.paginate(:page => params[:page], :per_page => 5)
  end

  def show
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to controller: 'organizations', action: 'show', id: @job.organization_id
    else
      render 'new'
    end
  end

  def new
    @job = Job.new
  end

  def update
  end


  def edit
  end

  private

  # define the jobs parameters
    def job_params
      params.require(:job).permit(:title, :user_id, :organization_id)
    end

end
