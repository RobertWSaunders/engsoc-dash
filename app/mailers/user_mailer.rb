class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @url = root_url
    subject = "Welcome to Dash"
    # mail(:to => @user.email, :subject => "Welcome to Dash")
  end

  def submit_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    subject = "Job Application for " + @job_application.job_posting.title
    # mail(:to => @user.email, :subject => "Job Application for " + @job_application.job_posting.title)
  end

  def hire_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    subject = "Congratulations! You have been hired as a " + @job_application.job_posting.title
    # mail(:to => @user.email, :subject => "Congratulations! You're now a " + @job_application.job_posting.title)
  end

  def decline_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    # mail(:to => @user.email, :subject => "Regarding your Job Application for " + @job_application.job_posting.title)
  end

  # commentout mail to prevent breaking on heroku for now


  private

    # check preference and send
    def send_mail(recipient,subject)
      user = User.find_by(email: recipient)
      if user.email_notifications
        mail(:to => recipient, :subject => subject)
      else
        p recipient + " has email notifications turned off."
      end
    end

end
