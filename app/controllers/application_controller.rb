class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_action :require_authentication

  private
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

  # Require an administrator to request a participant that isn't one's self
  #   nil participnat_id imples requesting self.
  # Redirect non-admins requesting other participants to redirect_url,
  #   typically the self-referential url (e.g.
  #   participant_transcript_url => transcript_url), hence no flash
  # N.B.: For actions that use a participant_id to reference
  #   other participants ONLY
  def require_administrator_or_self( redirect_url=root_url )
    unless administrator? or
        params[:participant_id].nil?
      redirect_to redirect_url
    end
  end

end
