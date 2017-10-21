class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @url = root_url
    subject = "Welcome to Dash"
    send_mail(@user,subject)
  end

  def submit_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    subject = "Job Application for " + @job_application.job_posting.title
    send_mail(@user,subject)
  end

  def hire_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    subject = "Congratulations! You have been hired as a " + @job_application.job_posting.title
    send_mail(@user,subject)
  end

  def decline_job_application(job_application)
    @job_application = job_application
    @user = @job_application.user
    subject = "Job Application update for " + @job_application.job_posting.title
    send_mail(@user,subject)
  end

  # commentout mail to prevent breaking on heroku for now


  private

    # check preference and send
    def send_mail(recipient,subject)
      if recipient.email_notifications
        mail(:to => recipient.email, :subject => subject)
      else
        p "recipient has email notifications turned off."
      end
    end

end
