class Participants::ActivitiesController < ApplicationController
  respond_to :html, :json

  def destroy
    @a = Participants::Activity.find( params[:id] )
    p = @a.participant
    @a.destroy unless @a.nil?
    respond_to do |format|
      format.html { redirect_to participant_url( id: p.andrewid ) }
      format.js
    end
  end

  def update
    @a = Participants::Activity.find( params[:id] )
    @a.assign_attributes(params[:participants_activities_additional], :without_protection => true)
    @a.save!
    respond_with @a
  end
  
end
