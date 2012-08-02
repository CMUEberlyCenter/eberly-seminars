class ParticipantMailer < ActionMailer::Base
  default from: "Eberly Center Seminars <seminars@eberly.cmu.edu>"

  def pending_registration_email(participant)
    @participant = participant
    mail(:to => participant.email, 
         :cc => "jmbrooks@andrew.cmu.edu", 
         :subject => "[Eberly Center] Seminar Registration Received")
  end
end
