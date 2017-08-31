class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @url = root_url
    # mail(:to => @user.email, :subject => "Welcome to Dash")
  end

  def submit_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    # mail(:to => @user.email, :subject => "Job Application for " + @job_application.job_posting.title)
  end

  def hire_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    # mail(:to => @user.email, :subject => "Congratulations! You're now a " + @job_application.job_posting.title)
  end

  def decline_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    # mail(:to => @user.email, :subject => "Regarding your Job Application for " + @job_application.job_posting.title)
  end

  # commentout mail to prevent breaking on heroku for now

end
