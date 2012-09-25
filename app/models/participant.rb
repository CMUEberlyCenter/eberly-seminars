class Participant < ActiveRecord::Base
  has_many :registrations
  has_many :seminars, :through => :registrations

  def is_administrator?
    self.is_admin == 1
  end

  def registration_for( seminar )
    self.registrations.find_by_seminar_id( seminar.id )
  end

  def ldap_reference
    @ldap_reference ||= CarnegieMellonPerson.find_by_andrewid( self.andrewid )
  end

  def name
    Array.[](ldap_reference["cn"]).flatten.last
  end
  
  def email
    ldap_reference["mail"]
  end

  def department
    ldap_reference["cmuDepartment"]
  end

  def student_class
    ldap_reference["cmuStudentClass"]
  end

  def request_registration( seminar )
    status = RegistrationStatus.find_by_status( 'pending' )
    registration = self.registrations.build( :seminar_id => seminar, :registration_status => status )
    registration.save
    ParticipantMailer.registration_pending_email( self, registration ).deliver
  end

  def cancel_registration( registration_id )
    registration = self.registrations.find( registration_id )
    registration_copy = registration.clone
    registration.destroy
    ParticipantMailer.canceled_registration_email( registration_copy ).deliver
  end

end
