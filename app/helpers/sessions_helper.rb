module SessionsHelper

  ###
  # The username of the pubcookie-authenticated principal or nil if not authenticated
  def http_remote_user
    !request.env['REMOTE_USER'].nil? ? request.env['REMOTE_USER'].split('@')[0] : nil
    "meribyte"
  end

  ###
  # The realm of the pubcookie-authenticated principal or nil if not authenticated
  def http_remote_user_realm
    !request.env['REMOTE_USER'].nil? ? request.env['REMOTE_USER'].split('@')[1] : nil
    "andrew.cmu.edu"
  end

  ###
  # Retrieve or create a participant object for the authenticated user
  def login(username)
    self.current_user = Participant.find_by_andrewid( username )
    if current_user.nil?
      self.current_user = Participant.create( :andrewid => username )
    end
    session[:remember_token] = current_user.id
  end

  ###
  # Destroy the session of the current user
  def logout
    session[:remember_token] = nil
  end

  ###
  # Set the current user to a particular participant
  # @param {Participant} participant The participant
  def current_user=(participant)
    @current_user = participant
  end

  ###
  # The currently authenticated user
  def current_user
    @current_user ||= Participant.find_by_id(session[:remember_token])
  end

  ###
  # If there is an authenticated user
  def authenticated?
    !current_user.nil?
  end

  ###
  # If there is an authenticated user and that user is an administrator
  def administrator?
    !current_user.nil? && current_user.is_admin?
  end

end
