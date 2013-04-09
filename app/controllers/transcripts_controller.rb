class TranscriptsController < ApplicationController
  before_filter :require_authentication
  before_filter :require_administrator, :only => :index


  def index
    @participant = Participant.find_by_id(params[:participant_id])
    if @participant.registrations
      @attended_seminars = @participant.registrations.credited
    end

    respond_to do |format|
      format.html
      format.pdf
    end

  end


end
