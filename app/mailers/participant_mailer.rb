class ParticipantMailer < ActionMailer::Base
  default from: "Eberly Center Seminars <seminars@eberly.cmu.edu>"

  def pending_registration_email(participant, registration)
    @participant = participant
    @registration = registration
    mail(:to => participant.email, 
         :cc => "jmbrooks@andrew.cmu.edu", 
         :subject => "[Eberly Center] Registration Request Received")
  end

  def confirmed_registration_email(participant, registration)
    @participant = participant
    @registration = registration
    mail(:to => participant.email, 
         :cc => "jmbrooks@andrew.cmu.edu", 
         :subject => "[Eberly Center] Seminar Registration Confirmed")
  end

  def seminar_one_week_reminder_email(registration)
    if registration.confirmed?
      template = 'one_week_reminder_email_confirmed'
    else
      template = 'one_week_reminder_email_pending'
    end

    mail(:to => registration.participant.email,
         :cc => "jmbrooks@andrew.cmu.edu",
         :subject => "[Eberly Center] Teaching Seminar Reminder",
         :template_name => template )
  end

end
