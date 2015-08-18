class Participants::ActivitiesController < ApplicationController
  respond_to :html, :json

  def edit
    @activity = Participant::Activity.find( params[:id] )
    @activity.becomes( @activity.type.constantize )
    respond_to do |format|
      format.js
    end
  end
  
  def create
    p = Participant.find( params[:participant_id] )
    @activity = p.activities.create!( activity_params )
    
    respond_to do |format|
      format.html { redirect_to p }
      format.js
    end
  end

  
  def destroy
    @a = Participant::Activity.find( params[:id] )
    p = @a.participant
    @a.destroy unless @a.nil?
    respond_to do |format|
      format.html { redirect_to participant_url( id: p.andrewid ) }
      format.js
    end
  end

  def update
#    @participant = Participant.find params[:id]
    @a = Participant::Activity.find( params[:id] )
    @a.update_attributes!( activity_params )
    #@a.assign_attributes(params[:participant_activities_additional], :without_protection => true)
    @a.save!
    #respond_with @a
    respond_to do |format|
      format.js
    end
  end

  private
  def activity_params
    if current_user.is_admin?
      params.require(:participant_activity).permit(:type, :description, :title, :completed_on, :internal_notes, :course, :memo_completed_on, :lead_consultant_id, :observer_id, :observer, :future_faculty_requirement_id)
    else
      params.require(:participant_activity).permit(nil)
    end
  end
  
    
end
