class ParticipantMailer < ActionMailer::Base
  default from: "Eberly Center <seminars@eberly.cmu.edu>"

  def ffp_graduation_email( participant )
    @participant = participant
    mail(:to => participant.email,
         :cc => "seminars-cc@eberly.cmu.edu",
         :subject => "[Eberly Center] Congrats you're done with FFP")
    
  end
  
  def registration_pending_email(participant, registration)
    @participant = participant
    @registration = registration
    mail(:to => participant.email, 
         :cc => "seminars-cc@eberly.cmu.edu", 
         :subject => "[Eberly Center] Request for #{registration.seminar.title}")
  end

  def registration_confirmed_email(participant, registration)
    @participant = participant
    @registration = registration
    mail(:to => participant.email, 
         :cc => "seminars-cc@eberly.cmu.edu", 
         :subject => "[Eberly Center] Confirmation for #{registration.seminar.title}")
  end

  def canceled_registration_email( registration )
    @registration = registration
    subject = ""

    if @registration.confirmed?
      template = 'canceled_confirmed_registration_email'
      subject = "Canceled registration for #{registration.seminar.title}"
    else
      template = 'canceled_pending_registration_email'
      subject = "Canceled request for #{registration.seminar.title}"
    end

    mail(:to => @registration.participant.email,
         :cc => "seminars-cc@eberly.cmu.edu",
         :subject => "[Eberly Center] #{subject}",
         :template_name => template )
  end

  def generic_reminder_email( registration )
    @registration = registration
    subject = ""

    if @registration.confirmed?
      template = 'generic_reminder_email_confirmed'
      subject = "Reminder: #{registration.seminar.title}"
    elsif @registration.pending?
      template = 'generic_reminder_email_pending'
      subject = "Waitlisted for #{registration.seminar.title}"
    else
      return
    end

    mail(:to => @registration.participant.email,
         :cc => "seminars-cc@eberly.cmu.edu",
         :subject => "[Eberly Center] #{subject}",
         :template_name => template )
  end

end
