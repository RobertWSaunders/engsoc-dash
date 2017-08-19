class StaticPagesController < ApplicationController
  def home
    #@job_postings = JobPosting.find(:all, :limit => 1)
    @job_postings = JobPosting.where(status: "open").order(:deadline).limit(3)
    @job_applications = JobApplication.where(user_id: current_user.id).filter(params.slice(:status))
  end

  def about
  end

  def contact
  end

  def credits
  end

  def changes
  end

  def settings
  end
end
