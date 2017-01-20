class OrganizationsController < ApplicationController

  load_and_authorize_resource

  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 5)
    @organization = Organization.new
  end

  def show
    @organization = Organization.find(params[:id])
    if @organization.job_postings.present?
      @job_postings = Job_postings.where(:organization_id => Organization.find(params[:organization_id]))
    end
  end

  def create
    @organization = Organization.new(organization_params)
    @users = User.where(:id => params[:organization_users])
    @organization.users << @users
    if @organization.save
      redirect_to organizations_path
    else
      redirect_to :back
    end
  end

  def new
    @organization = Organization.new
  end

  def update
  end


  def edit
  end

  private

  # define the jobs parameters
    def organization_params
      params.require(:organization).permit(:name, :description, :email, :user_ids => [])
    end

end
