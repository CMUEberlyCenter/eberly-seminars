class TranscriptController < ApplicationController
  before_filter :require_authentication

  def index
    if current_user.registrations
      @attended_seminars = current_user.registrations.credited
    end

    respond_to do |format|
      format.html
      format.pdf
    end
  end

end
