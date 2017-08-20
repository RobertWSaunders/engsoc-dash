class UserMailer < ApplicationMailer

  def welcome
    user = User.first
    @user = user
    mail(:to => @user.email, :subject => "Welcome!")
  end
end
