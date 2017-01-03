class PagesController < ApplicationController
  def dashboard
    @approval_job_postings = JobPosting.where(status: 0).order(:deadline)
    @interviewing_job_postings = JobPosting.where(status: 2).order(:deadline)
    @closed_job_postings = JobPosting.where(status: 3).order(:deadline)
  end
end
