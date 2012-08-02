module RegistrationsHelper

  def participant_calendar
    RiCal.Calendar do |cal|
      current_user.registrations.confirmed.each do |registration|
        cal.event do |event|
          event.description registration.seminar.description
          event.summary registration.seminar.title
          event.dtstart registration.seminar.start_at.strftime("%Y%m%dT%H%M%S")
          event.dtend registration.seminar.end_at.strftime("%Y%m%dT%H%M%S")
          event.location registration.seminar.location
          event.add_attendee current_user.email
          event.alarm do
            description "Eberly Center Teaching Seminar"
          end
        end # event
      end # registration
    end # cal
  end

  def participant_calendar_filename
    "#{current_user.name} - Eberly Seminars.ics"
  end

end
