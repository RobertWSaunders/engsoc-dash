class PositionsController < ApplicationController

  # GET /positions/admin
  def admin
    @positions = Position.all.joins(:job).order("jobs.organization_id").reverse_order
  end

end
