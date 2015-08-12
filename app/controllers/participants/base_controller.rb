class Participants::BaseController < ApplicationController
  before_filter :require_administrator, only: :enroll


  def index
    @participants = Participant.all
  end


  def show
    @participant = Participant.find params[:id]
    if @participant.nil? && CarnegieMellonPerson.find_by_andrewid( params[:id] )
      @participant = Participant.create andrewid: params[:id]
    end

    respond_to do |format|
      format.html
    end

  rescue ActiveLdap::EntryNotFound
    # TODO: participants_url/did you mean? results
    redirect_to( root_url,
                 :flash => { :error => "Participant does not exist." } )
  end


  def update
    @participant = Participant.find( params[:id] )
    @participant.update_attributes!( participant_params )

    respond_to do |format|
      format.js
    end
  end

  def create
    @participant = Participant.find_andrew_user participant_params[:andrewid]
    @participant.update_attributes!( participant_params ) unless @participant.nil?
    respond_to do |format|
      format.html { redirect_to :back }
    end
  end

  private
  def participant_params
    if current_user.is_admin?
      params.require(:participant).permit(:andrewid, :note, :is_admin, :consultant, :activities_attributes => [:type, :id, :title, :description], :additional_activities_attributes => [:title,:description])
    else
      params.require(:participant).permit(nil)
    end
  end
  
end
