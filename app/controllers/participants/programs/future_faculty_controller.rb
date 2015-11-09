class Participants::Programs::FutureFacultyController < ApplicationController

  def index
    respond_to do |format|
      format.xlsx do
        @participants = Participant.where('future_faculty_enrollment_id is not null')
        #@participants = Programs::FutureFaculty::RequirementsVersion.last.participants
        response.headers['Content-Disposition'] = 'attachment; filename="FutureFacultyParticipants.xlsx"'
      end
    end
  end
  
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
