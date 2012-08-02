class RegistrationsController < ApplicationController
  before_filter :require_authentication
  include RegistrationsHelper


  def index
    respond_to do |format|
      format.ics do
        send_data( participant_calendar.export, 
                   :filename => participant_calendar_filename,
                   :disposition => "inline; #{participant_calendar_filename}",
                   :type=>"text/calendar"
                   )
      end
      format.html{ redirect_to seminars_path }
    end
    
  end


  def create
    current_user.request_registration( params[:seminar_id] )

    respond_to do |format|
      format.js
      format.html { redirect_to seminars_path }
    end
  end


  def destroy
    current_user.cancel_registration( params[:id] )

    respond_to do |format|
      format.js
      format.html { redirect_to seminar_path }
    end
  end 

end
