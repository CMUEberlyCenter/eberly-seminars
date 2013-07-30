class SessionsController < ApplicationController
  before_filter :require_andrew_realm, :only => :create
  
  ###
  # Login the user
  def create
    login( http_remote_user )

    if params[:return_url]
      redirect_to params[:return_url]
    elsif administrator?
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
    redirect_to "https://webiso.andrew.cmu.edu/logout.cgi"
  end


  protected

  ###
  # Redirect unless the user is from andrew.cmu.edu
  def require_andrew_realm
    unless http_remote_user_realm == 'andrew.cmu.edu'
      flash[:error] = "You are authenticated to the #{http_remote_user_realm}
                       realm. Please use WebISO to login as an @andrew.cmu.edu
                       user"
      redirect_to root_url
    end
  end

end
