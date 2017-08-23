class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @url = root_url
    mail(:to => @user.email, :subject => "Welcome to Dash")
  end

  def new_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    mail(:to => @user.email, :subject => "Successfully Applied to " + @job_application.job_posting.title)
  end

end
