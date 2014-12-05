class ParticipantsController < ApplicationController
  before_filter :require_administrator


  def index
    @participants = Participant.all
  end


  def show
    @participant = Participant.find_or_create params[:id]

    respond_to do |format|
      format.html
    end
  rescue
    # TODO: participants_url/did you mean? results
    redirect_to( root_url,
                 :flash => { :error => "Participant does not exist." } )
  end # show


  def update
    @participant = Participant.find(params[:id])
    @participant.update_attributes(params[:participant])
    @participant.save

    respond_to do |format|
      format.js
    end
  end

  
  def enroll
    @participant = Participant.find_by_andrewid(params[:id])
    @participant.in_future_faculty = true
    @participant.save
  end


end
