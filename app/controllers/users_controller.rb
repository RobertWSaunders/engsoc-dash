class UsersController < ApplicationController

  def index
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

end
