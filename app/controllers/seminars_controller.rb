class SeminarsController < ApplicationController

  def index
    @seminars = Seminar.active.published
  end


end
