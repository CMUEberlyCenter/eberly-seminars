class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protected
  def require_authentication
    unless authenticated?
      flash[:message] = "Log in to register for seminars"
      redirect_to root_url
    end
  end
end
