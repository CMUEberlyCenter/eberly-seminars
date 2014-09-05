class ObservationsController < ApplicationController
  respond_to :html, :json

  def destroy
    @a = Observation.find( params[:id] )
    p = @a.participant
    @a.destroy unless @a.nil?
    respond_to do |format|
      format.html { redirect_to participant_url( id: p.andrewid ) }
      format.js
    end
  end

  def update
    @a = Observation.find( params[:id] )
    @a.update_attributes(params[:observation])
    respond_with @a
  end

end
