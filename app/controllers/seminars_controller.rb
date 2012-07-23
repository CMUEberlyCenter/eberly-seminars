class SeminarsController < ApplicationController

  def index
    if administrator?
      redirect_to admin_seminars_url

    elsif authenticated?
      redirect_to registrations_url
      
     else
      @seminars = Seminar.current_semester.published
    end
  end

end
