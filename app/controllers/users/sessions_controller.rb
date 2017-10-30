class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    # SSO login
    if Rails.env.production?
      user_email = request.headers["HTTP_EMAIL"]
      user_givenName = request.headers["givenName"]
      user_surname = request.headers["surname"]

      if user = User.where(:email => user_email).first
        sign_in(:user, user)
        flash[:success] = "Welcome to Dash"
        session[:return_to] ||= request.referer
      else
        new_user = User.new(:email => user_email,
                       :first_name => user_givenName,
                        :last_name => user_surname)
        if new_user.save
          sign_in(:user, new_user)
          session[:return_to] ||= request.referer
        else
          p "User Creation Failure"
          redirect_to "https://idptest.queensu.ca/idp/profile/Logout"
        end
      end
    else
      super
    end

    # user = User.where(:email => 'test@example.com').first
    # sign_in(:user,user)
    # flash[:success] = "You have successfully logged in"
    # redirect_to root_path
    # super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
