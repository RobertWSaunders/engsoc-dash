class JobsController < ApplicationController
  load_and_authorize_resource
  def index
    @jobs = Job.all
  end

end
