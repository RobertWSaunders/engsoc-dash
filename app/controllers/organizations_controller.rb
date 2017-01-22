class OrganizationsController < ApplicationController

  load_and_authorize_resource

  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @organization = Organization.find(params[:id])
    if @organization.job_postings.present?
      @job_postings = Job_postings.where(:organization_id => Organization.find(params[:organization_id]))
    end
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to organizations_path
    else
      render 'new'
    end
  end

  def new
    @organization = Organization.new
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(organization_params)
      redirect_to controller: 'organizations', action: 'show', id: @organization.id
    else
      render 'edit'
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  private

  # define the jobs parameters
    def organization_params
      params.require(:organization).permit(:name, :description, :email, :user_ids)
    end

end
