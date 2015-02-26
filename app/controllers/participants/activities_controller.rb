class Participants::ActivitiesController < ApplicationController
  respond_to :html, :json

  def create
    p = Participant.find( params[:participant_id] )
    @activity = p.activities.create!( activity_params )

    respond_to do |format|
      format.html { redirect_to p }
      format.js
    end
  end

  
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
#    @participant = Participant.find params[:id]
    @a = Participants::Activity.find( params[:id] )
    @a.assign_attributes(params[:participants_activities_additional], :without_protection => true)
    @a.save!
    respond_with @a
  end

  private
  def activity_params
    if current_user.is_admin?
      params.require(:participants_activity).permit(:type, :description, :title )
    else
      params.require(:participants_activity).permit(nil)
    end
  end
  
    
end
