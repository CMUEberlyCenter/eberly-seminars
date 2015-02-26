class Participants::BaseController < ApplicationController
  before_filter :require_administrator, only: :enroll


  def index
    @participants = Participant.all
  end


  def show
    @participant = Participant.find_or_create_by( andrewid:  params[:id] )

    respond_to do |format|
      format.html
    end
#  rescue
    # TODO: participants_url/did you mean? results
#    redirect_to( root_url,
#                 :flash => { :error => "Participant does not exist." } )
  end # show


  def update
    @participant = Participant.find( params[:id] )
    @participant.update_attributes!( participant_params )

    respond_to do |format|
      format.js
    end
  end

  private
  def participant_params
    if current_user.is_admin?
      params.require(:participant).permit(:note, :activities_attributes => [:type, :id, :title, :description], :additional_activities_attributes => [:title,:description])
    else
      params.require(:participant).permit(nil)
    end
  end
  
end
