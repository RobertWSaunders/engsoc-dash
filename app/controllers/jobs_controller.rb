class JobsController < ApplicationController
<<<<<<< HEAD
  load_and_authorize_resource
=======



  before_action :set_user, only: [:show, :destroy, :edit, :update]

>>>>>>> implement-jobs
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

  # define the jpbs parameters
    def secure_params
      params.require(:job).permit(:title, :description)
    end

    def set_job
      @job = Jobs.find(params[:id])
    end
end
