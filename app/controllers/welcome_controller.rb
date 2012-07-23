class WelcomeController < ApplicationController
  layout "application-new"
  def index
    @_current_user = nil
    session[:participant_id] = nil
    @seminars = Seminar.active.published
  end
end
