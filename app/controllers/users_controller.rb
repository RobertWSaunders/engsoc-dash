class UsersController < ApplicationController

  load_and_authorize_resource
  before_action :set_user, only: [:show, :destroy, :edit, :update]

  def index
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user
  end

  def edit
    @user
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to controller: 'users', action: 'show', id: @user.id
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:preferred_name, :tagline, :bio, :faculty, :specialization, :gender)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
