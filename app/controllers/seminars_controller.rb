class SeminarsController < ApplicationController

  def index
    if administrator?
      flash.keep
      redirect_to admin_seminars_url
     else
      @seminars = Seminar.active.published
    end
  end

end
