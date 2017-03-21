class OrganizationsController < ApplicationController

  load_and_authorize_resource

  before_action :set_organization, only: [:show, :destroy, :edit, :update, :approve, :withdraw]

  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @jobs = @organization.jobs.order(role: :desc, created_at: :asc)
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to controller: 'organizations', action: 'show', id: @organization.id
    else
      render 'new'
    end
  end

  def new
    @organization = Organization.new
  end

  def update
    if @organization.update_attributes(organization_params)
      redirect_to controller: 'organizations', action: 'show', id: @organization.id
    else
      render 'edit'
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def destroy
    @organization.destroy
    redirect_to organizations_url
  end

  def manage
    @approval_organizations = Organization.where(status: "waiting_approval")
    @active_organizations = Organization.where(status: "active")
    @archived_organizations = Organization.where(status: "archived")
  end

  def approve
    @organization.status = "active"
    @organization.save
    redirect_to organizations_manage_path
  end

  def withdraw
    @organization.status = "waiting_approval"
    @organization.save
    redirect_to organizations_manage_path
  end

  def archive
    @organization.status = "archived"
    @organization.save
    redirect_to organizations_manage_path
  end

  def user_organizations
  end

  private

  # define the jobs parameters
    def organization_params
      params.require(:organization).permit(:name, :description, :email, :status)
    end

    def set_organization
      @organization = Organization.find(params[:id])
    end
end
