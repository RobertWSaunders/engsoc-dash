class PagesController < ApplicationController

  $title = "Dashboard"

  before_action :authenticate_user!

  def dashboard

  end
end
