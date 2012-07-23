class RegistrationsController < ApplicationController

before_filter :require_authentication


def index
@registrations = current_user.registrations
  @unregistered_seminars = Seminar.active.current_semester.published.select{ |s| s.registrations.find_by_participant_id(current_user) == nil }
  @seminars = Seminar.current_semester.expired

  @new_registrations = Array.new
  @unregistered_seminars.each{ |s| @new_registrations << Registration.new( :seminar => s )}

    cal =RiCal.Calendar do |c|
      current_user.registrations.each do |r|
        c.event do |event|
          event.description r.seminar.description
          event.summary r.seminar.title
          event.dtstart r.seminar.start_at.strftime("%Y%m%dT%H%M%S")
          event.dtend r.seminar.end_at.strftime("%Y%m%dT%H%M%S")
          event.location r.seminar.location
        event.add_attendee "#{current_user.andrewid}@andrew.cmu.edu"
          event.alarm do
            description "Eberly Teaching Seminar"
          end
        end
      end
    end
 respond_to do |format|
   format.ics { send_data(cal.export, :filename=>"#{current_user.andrewid}-seminar-schedule.ics", :disposition=>"inline; filename=#{current_user.andrewid}-seminar-schedule.ics", :type=>"text/calendar")}
   format.html{ }
   format.js
end

end


def create
  @new_seminars = Array.new
  unless params[:register].nil?
    status = RegistrationStatus.find_by_status('pending')
    params[:register].values.each do |v|
      unless v == "0"
        @new_seminars.append( v )
        Registration.create( :seminar_id => v, :participant_id => current_user.id, :registration_status => status )
      end
    ParticipantMailer.pending_registration_email( current_user ).deliver
    end
  end

  respond_to do |format|
    format.js
    format.html { redirect_to :action => 'index' }
  end
end

def destroy
  registration = current_user.registrations.find( params[:id] )
  if registration
    Registration.destroy( params[:id] )
  end

  respond_to do |format|
    format.js
    format.html { redirect_to :action => 'index' }
  end
end 

end
