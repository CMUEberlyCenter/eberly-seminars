class Participants::TranscriptsController < ApplicationController
  before_filter -> { require_administrator_or_self transcript_url }

  def show

    # Determine for which participant to show transcript
    if params[:participant_id].nil?
      @participant = current_user
    else
      @participant = Participant.find_by_andrewid params[:participant_id]
    end

    # Check that participant exists and render transcript according to
    # requested format
    if @participant.nil?
      redirect_to( participants_url,
                   :flash => { :error => "Participant does not exist." } )
    else
      respond_to do |format|
        format.html
        format.pdf
      end
    end

  end # show


end
