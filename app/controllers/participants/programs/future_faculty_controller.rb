class Participants::Programs::FutureFacultyController < ApplicationController

  def index
    respond_to do |format|
      format.xlsx do
        @participants = Participant.all
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

  def graduate
    @participant = Participant.find( params[:participant_id] )

    unless Programs::FutureFaculty::Enrollment.find( @participant ).nil?
      @participant.future_faculty_progress_status_id = 3
      @participant.future_faculty_program_graduated_on = Date.today
      @participant.save
    end

    redirect_to @participant
  end

  def ungraduate
    @participant = Participant.find( params[:participant_id] )

    unless Programs::FutureFaculty::Enrollment.find( @participant ).nil?
      @participant.future_faculty_progress_status_id = 2
      @participant.save
    end

    respond_to do |format|
      format.js
    end
  end

  def drop
    @participant = Participant.find( params[:participant_id] )
    unless Programs::FutureFaculty::Enrollment.find( @participant ).nil?
      @participant.future_faculty_progress_status_id = 4
      @participant.save
    end
    redirect_to @participant
  end

  def undrop
    @participant = Participant.find( params[:participant_id] )
    unless Programs::FutureFaculty::Enrollment.find( @participant ).nil?
      @participant.future_faculty_progress_status_id = 1
      @participant.save
    end

    respond_to do |format|
      format.js
    end
  end

  def reenroll
    @participant = Participant.find( params[:participant_id] )
    unless Programs::FutureFaculty::Enrollment.find( @participant ).nil?
      @participant.future_faculty_progress_status_id = 1
      @participant.save
    end
    redirect_to @participant
  end


end
