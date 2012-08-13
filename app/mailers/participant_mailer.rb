class ParticipantMailer < ActionMailer::Base
  default from: "Eberly Center Seminars <seminars@eberly.cmu.edu>"

  def registration_pending_email(participant, registration)
    @participant = participant
    @registration = registration
    mail(:to => participant.email, 
         :cc => "jmbrooks@andrew.cmu.edu", 
         :subject => "[Eberly Center] Registration Request Received")
  end

  def registration_confirmed_email(participant, registration)
    @participant = participant
    @registration = registration
    mail(:to => participant.email, 
         :cc => "jmbrooks@andrew.cmu.edu", 
         :subject => "[Eberly Center] Seminar Registration Confirmed")
  end

  def generic_reminder_email( registration )
    @registration = registration
    if @registration.confirmed?
      template = 'generic_reminder_email_confirmed'
    else
      template = 'generic_reminder_email_pending'
    end

    mail(:to => @registration.participant.email,
         :cc => "jmbrooks@andrew.cmu.edu",
         :subject => "[Eberly Center] Teaching Seminar Reminder",
         :template_name => template )
  end

end
