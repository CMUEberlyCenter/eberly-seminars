class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protected
  def require_authentication
    unless authenticated?
      redirect_to login_url(:return_url => request.env["REQUEST_URI"])
    end
  end

  def require_administrator
    unless administrator?
      flash[:error] = "Administrator access required"
      redirect_to root_url
    end
  end

end
