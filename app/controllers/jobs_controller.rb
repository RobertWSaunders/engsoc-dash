class JobsController < ApplicationController

  load_and_authorize_resource

  def index
    @jobs = Job.paginate(:page => params[:page], :per_page => 5)
    @organization = Organization.find(params[:organization_id])
  end

  def show
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to controller: 'jobs', action: 'show', id: @job.id
    else
      render 'new'
    end
  end

  def new
    @job = Job.new
    @organization = Organization.find(params[:organization_id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      redirect_to controller: 'jobs', action: 'show', id: @job.id
    else
      render 'edit'
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def destroy
    job = Job.find(params[:id]).destroy
    redirect_to organization_jobs_path(job.organization_id)
  end

  private

  # define the jobs parameters
    def job_params
      params.require(:job).permit(:title, :user_id, :organization_id)
    end

end
