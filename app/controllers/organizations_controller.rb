class OrganizationsController < ApplicationController

  load_and_authorize_resource

  before_action :set_organization, only: [:show, :destroy, :edit, :update]

  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 5)
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

  # define the jobs parameters
    def organization_params
      params.require(:job).permit(:title, :description)
    end

    def set_organization
      @organizations = Organizations.find(params[:id])
    end
end
