class Participants::Programs::FutureFacultyController < ApplicationController

  def enroll
    @participant = Participant.find( params[:participant_id] )
    Programs::FutureFaculty::Enrollment.new( @participant )

    respond_to do |format|
      format.js
    end
  end

  def unenroll
    @participant = Participant.find( params[:participant_id] )
    Programs::FutureFaculty::Enrollment.destroy( @participant )

    respond_to do |format|
      format.js
    end
  end

end
