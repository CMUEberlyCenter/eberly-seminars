class SessionsController < ApplicationController
  before_filter :require_andrew_realm, :only => :create
  
  ###
  # Login the user
  def create
    login( http_remote_user )

    if administrator?
      redirect_to admin_seminars_url
    else
      redirect_to seminars_url
    end
  end

  ###
  # Logout and then redirect user to the main page
  def destroy
    logout

    flash[:success] = "Successfully logged out."
    redirect_to root_url
  end


  protected

  ###
  # Redirect unless the user is from ANDREW.CMU.EDU
  def require_andrew_realm
    unless http_remote_user_realm == 'ANDREW.CMU.EDU'
      flash[:error] = "You are authenticated to the #{http_remote_user_realm}
                       realm. Please use WebISO to login as an @ANDREW.CMU.EDU
                       user"
      redirect_to root_url
    end
  end

end
