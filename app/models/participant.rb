class Participant < ActiveRecord::Base
  has_many :registrations
  has_many :seminars, :through => :registrations
  belongs_to :future_faculty_enrollment, class_name: FutureFaculty::RequirementsVersion

  has_many :activities, class_name: Participants::Activity, dependent: :destroy
  
  has_many :additional_activities, class_name: Participants::Activities::Additional, dependent: :destroy
  
  accepts_nested_attributes_for :additional_activities
  accepts_nested_attributes_for :activities

  attr_accessible :andrewid, :note, :activities_attributes

  default_scope { order("andrewid") }
  # TODO: default to fetching active students
  #  default_scope :active

  def self.find_or_create( andrewid )
    CarnegieMellonPerson.find_by_andrewid andrewid
    find_by_andrewid( andrewid ) || create( :andrewid => andrewid )
  end
    
  
  def completed_seminars
    self.registrations.credited.collect(&:seminar)
  end


 def is_administrator?
    self.is_admin == 1
  end

  def in_future_faculty_program?
    self.future_faculty_enrollment != nil
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
