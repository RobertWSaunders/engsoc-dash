class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    # SSO login
    if Rails.env.production?
      Rails.logger.debug "Custom new session path"
      user_email = request.headers["HTTP_EMAIL"]
      user_givenName = request.headers["givenName"]
      user_surname = request.headers["surname"]

      if user = User.where(:email => user_email).first
        Rails.logger.debug "User found"
        sign_in(:user, user)
        flash[:success] = "Welcome to Dash"
        flash.delete(:notice)
        session[:return_to] ||= request.referer
      else
        Rails.logger.debug "Creating user"
        new_user = User.new(:email => user_email,
                       :first_name => user_givenName,
                        :last_name => user_surname)
        if new_user.save
          Rails.logger.debug "User saved"
          sign_in(:user, new_user)
          flash[:success] = "Welcome to Dash!"
          flash.delete(:notice)
          redirect_to root_path
          # session[:return_to] ||= request.referer
        else
          Rails.logger.debug "User Creation Failure"
          redirect_to "https://idptest.queensu.ca/idp/profile/Logout"
        end
      end

    # # debug block for dev env
    # elsif Rails.env.development?
    #   @msg = "custom new session route"
    #   user_email = 'asdasdvasvasdv@hotmail.com'
    #   user_givenName = '4th'
    #   user_surname = 'emai :) l'
    #
    #   if user = User.where(:email => user_email).first
    #     sign_in(:user, user)
    #     flash[:success] = "Welcome back."
    #     flash.delete(:notice)
    #     redirect_to root_path
    #     # session[:return_to] ||= request.referer
    #   else
    #     new_user = User.new(:email => user_email,
    #                    :first_name => user_givenName,
    #                     :last_name => user_surname)
    #     if new_user.save!
    #       sign_in(:user, new_user)
    #       flash[:success] = "Welcome to Dash!"
    #       flash.delete(:notice)
    #       redirect_to root_path
    #     else
    #       p "User Creation Failure"
    #       redirect_to "https://idptest.queensu.ca/idp/profile/Logout"
    #     end
    #   end

    else
      Rails.logger.debug "default session path"
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
