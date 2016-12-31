class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before any action make sure the user is logged in
  before_action :authenticate_user!
  # before any action make sure the user has authorization
  #load_and_authorize_resource

  # if there is an exception from cancancan then we take the user to the 403 page, permission denied
  rescue_from CanCan::AccessDenied do |exception|
   render :file => "#{Rails.root}/public/403.html", :status => 403, :layout => false
  end
end
