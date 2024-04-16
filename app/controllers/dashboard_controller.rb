class DashboardController < ApplicationController

  def index
    @dashboard_data =  DashboardService.new(current_user).dashboard_data
  end
end
