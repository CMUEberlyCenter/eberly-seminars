class ParticipantsController < ApplicationController
  before_filter :require_administrator


  def index
    @participants = Participant.all
  end


  def show
    @participant = Participant.find_by_andrewid params[:id]

    # Check that participant exists and redirect if it doesn't
    if @participant.nil?
      redirect_to( participants_url,
                   :flash => { :error => "Participant does not exist." } )
    else
      respond_to do |format|
        format.html
      end
    end

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
