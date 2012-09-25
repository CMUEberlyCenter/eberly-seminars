class PortfolioController < ApplicationController

  def index
    if current_user.registrations
      @attended_seminars = current_user.registrations.attended
    end
  end

end
