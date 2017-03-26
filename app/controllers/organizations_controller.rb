class OrganizationsController < ApplicationController

  load_and_authorize_resource

  before_action :set_organization, only: [:show, :destroy, :edit, :update, :approve, :withdraw, :archive]

  # GET /organizations
  def index
    @organizations = Organization.where(status: "active").paginate(:page => params[:page], :per_page => 10)
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # POST /organizations
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to controller: 'organizations', action: 'show', id: @organization.id
    else
      render 'new'
    end
  end

  # GET /organizations/:id
  def show
    @jobs = @organization.jobs.order(role: :desc, created_at: :asc)
  end

  # GET /organizations/:id/edit
  def edit
    @organization = Organization.find(params[:id])
  end

  # PUT /organizations/:id
  def update
    if @organization.update_attributes(organization_params)
      redirect_to controller: 'organizations', action: 'show', id: @organization.id
    else
      render 'edit'
    end
  end

  # DELETE /organizations/:id
  def destroy
    @organization.destroy
    redirect_to organizations_url
  end

  # GET /organizations/admin
  def admin
    @organizations = Organization.filter(params.slice(:status)).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /organizations/user
  def user
  end

  # GET /organizations/:id/approve
  def approve
    @organization.status = "active"
    @organization.save
    redirect_to admin_organizations_path
  end

  # GET /organizations/:id/withdraw
  def withdraw
    @organization.status = "waiting_approval"
    @organization.save
    redirect_to admin_organizations_path
  end

  # GET /organizations/:id/archive
  def archive
    @organization.status = "archived"
    @organization.save
    redirect_to admin_organizations_path
  end

  def filter
    if params[:status] == "All"
      redirect_to admin_organizations_path
    else
      redirect_to admin_organizations_path(status: params[:status])
    end
  end

  private

    def organization_params
      params.require(:organization).permit(:name, :description, :email, :status)
    end

    def set_organization
      @organization = Organization.find(params[:id])
    end

end
