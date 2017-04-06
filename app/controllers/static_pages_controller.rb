class StaticPagesController < ApplicationController
  def home
    #@job_postings = JobPosting.find(:all, :limit => 1)
    @job_postings = JobPosting.where(status: "open").order(:deadline).limit(3)

  end

  def about
  end

  def contact
  end

  def credits
  end

  def settings
  end
end
