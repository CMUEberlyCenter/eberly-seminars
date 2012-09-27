class PortfolioController < ApplicationController
  before_filter :require_authentication

  def index
    if current_user.registrations
      @attended_seminars = current_user.registrations.credited
    end
  end

end
