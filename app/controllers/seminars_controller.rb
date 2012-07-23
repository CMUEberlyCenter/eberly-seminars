class SeminarsController < ApplicationController

  def index

    if administrator?
      flash.keep
      redirect_to admin_seminars_url

    elsif authenticated?
      flash.keep
      redirect_to registrations_url
      
     else
      @seminars = Seminar.current_semester.published
    end
  end

end
