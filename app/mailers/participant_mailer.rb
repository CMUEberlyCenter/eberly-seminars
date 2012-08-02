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
end
