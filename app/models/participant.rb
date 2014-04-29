class Participant < ActiveRecord::Base
  has_many :registrations
  has_many :seminars, :through => :registrations
  has_many :observations, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :activities, class_name: "ParticipantActivity", dependent: :destroy

  attr_accessible :note

  default_scope :order => "andrewid"

  def is_administrator?
    self.is_admin == 1
  end

  def in_future_faculty_program?
    self.in_future_faculty == true
  end

  def registration_for( seminar )
    self.registrations.find_by_seminar_id( seminar.id )
  end

  def ldap_reference
    @ldap_reference ||= CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    # Add new attributes to CarnegieMellonPerson attributes before adding 
    # references to them in participant.rb
  end

  def name
    Array.[](ldap_reference["cn"]).flatten.last
  end

  def surname
    ldap_reference["sn"]
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
    status = RegistrationStatus.find_by_key( 'pending' )
    registration = self.registrations.build( :seminar_id => seminar, :registration_status => status )
    registration.save
    ParticipantMailer.registration_pending_email( self, registration ).deliver
  end

  def cancel_registration( registration_id )
    
    registration = self.registrations.find( registration_id )
    registration_copy = registration.clone
    #registration.destroy
    registration_status = nil
    if registration.seminar.start_at < 1.day.from_now 
      registration_status = RegistrationStatus.find_by_key "cancelled_late"
    else
      registration_status = RegistrationStatus.find_by_key "cancelled"
    end
    registration.registration_status = registration_status
    registration.save
    ParticipantMailer.canceled_registration_email( registration_copy ).deliver
  end

end
