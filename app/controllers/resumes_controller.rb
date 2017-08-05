class ResumesController < ApplicationController

  before_action :set_resume

  # GET profiles/:profile_id/resumes
  def index
    @resume = Resume.new
  end

  # POST profiles/:profile_id/resumes
  def create
    @resume = Resume.new(resume_params)

    if @resume.save
      flash[:success] = "Resume <em>#{@resume.name}</em> has been uploaded."
      redirect_to profile_resumes_path
    else
      flash[:warning] = "Resume <em>#{@resume.name}</em> did not upload properly. Please make sure you have attached a file of the right format (PDF, DOC, DOCx) of under 2MB, and that you have given it a name, and try again."
      render "index"
    end
  end

  # DESTROY profiles/:profile_id/resumes/:resume_id
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
