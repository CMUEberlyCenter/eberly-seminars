class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protected
  def require_authentication
    unless authenticated?
      flash[:error] = "Log in to register for seminars"
      redirect_to root_url
    end
  end

  def require_administrator
    unless administrator?
      flash[:error] = "Administrator access required"
      redirect_to root_url
    end
  end

end
