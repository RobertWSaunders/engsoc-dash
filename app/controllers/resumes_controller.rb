class ResumesController < ApplicationController

  before_action :set_resume

  def index
    @resume = Resume.new
  end

  def create

    @resume = Resume.new(resume_params)

    if @resume.save
      flash[:success] = "Resume #{@resume.name} has been uploaded."
      redirect_to profile_resumes_path
    else
      flash[:warning] = "Resume #{@resume.name} did not upload properly. Please make sure it is the right file format, and try again."
      render "index"
    end
  end

  def destroy
    resume = Resume.find(params[:id])  
    resume.destroy
    flash[:success] = "Resume Successfully Deleted"
    redirect_to profile_resumes_path
  end

  private

    def resume_params
      params.require(:resume).permit(:name, :attachment, :user_id)
    end

    def set_resume
      @user = User.find(params[:profile_id])
      @resumes = @user.resumes.all
    end 
end
