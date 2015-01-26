class Participant::ActivitiesController < ApplicationController
  respond_to :html, :json

  def destroy
    @a = ParticipantActivity::Base.find( params[:id] )
    p = @a.participant
    @a.destroy unless @a.nil?
    respond_to do |format|
      format.html { redirect_to participant_url( id: p.andrewid ) }
      format.js
    end
  end

  def update
    @a = ParticipantActivity::Base.find( params[:id] )
    @a.assign_attributes(params[:participant_activity_additional], :without_protection => true)
    @a.save!
    respond_with @a
  end
  
end
