class JobsController < ApplicationController

  load_and_authorize_resource

  before_action :set_job, only: [:show, :assign, :destroy, :edit, :update]

  def index
    @jobs = Job.paginate(:page => params[:page], :per_page => 5)
    @organization = Organization.find(params[:organization_id])
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @job
  end

  def create
    @job = Job.new(job_params)
    @organization = Organization.find(params[:organization_id])
    if @job.save
      redirect_to controller: 'jobs', action: 'assign', id: @job.id
    else
      render 'new'
    end
  end

  def new
    @job = Job.new
    @organization = Organization.find(params[:organization_id])
  end

  def assign
    @job
  end

  def update
    if @job.update_attributes(job_params)
      redirect_to organization_job_path(:organization_id => @job.organization_id)
    else
      render 'edit'
    end
  end

  def edit
    @job
  end

  def destroy
    @job.destroy
    redirect_to organization_path(job.organization_id)
  end

  private

  # define the jobs parameters
    def job_params
      params.require(:job).permit(:title, :user_id, :organization_id, :description, :role)
    end

    def set_job
      @job = Job.find(params[:id])
    end
end
