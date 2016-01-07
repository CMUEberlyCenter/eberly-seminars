class Participant < ActiveRecord::Base
  # for now -> calendar
  has_many :registrations
#  has_many :seminars, :through => :registrations
  #scope :program_requirements, -> (program) { where.not("#{program}_requirement_id".to_sym => nil) }
  #has_many :workshops, through: :registrations, foreign_key: "seminar_id"
#  has_many :workshop_registrations, source: :registrations

  has_many :activities, class_name: Participant::Activity, dependent: :destroy,
           inverse_of: :participant, autosave: true
  
  # Program associations
  belongs_to :future_faculty_enrollment, class_name: Programs::FutureFaculty::RequirementsVersion
  belongs_to :future_faculty_progress_status, class_name: Program::ProgressStatusType

  before_save :update_program_progress_statuses

  # Recalculate progress in programs
  def update_program_progress_statuses
    ffp_requirements = self.future_faculty_enrollment
    ffp_requirements.calculate_participant_status( self ) if ffp_requirements
  end



#  has_many :additional_activities, class_name: Participants::Activities::Additional, dependent: :destroy
  #
  #accepts_nested_attributes_for :additional_activities
  accepts_nested_attributes_for :activities

  # Use andrewid instead of participant's primary key
  def to_param
    self.andrewid
  end

  # First retrieve based on an andrewid and then fall back to primary key
  def self.find( param )
    param.to_i == 0 ? find_by_andrewid( param ) : super
  end

  
  # Attended event calculations
  has_many( :attended_workshops, -> { with_tag( "workshop" ) },
            through: :attended_registrations, source: :seminar )
  has_many( :attended_seminars, -> { without_tag( "workshop" ) },
            through: :attended_registrations, source: :seminar )
  # helper for attended_workshops and attended_seminars relations
  has_many :attended_registrations, -> { attended }, class_name: "Registration"  


  
#  has_many :attended_workshops, -> { joins(:registrations).where(attended) }, through: :registrations, source: :seminar
           #, #joins(:workshopregistrations).merge(Book.available)
  
  
#  attr_accessible :andrewid, :note, :activities_attributes

#  default_scope { order("andrewid") }
  # TODO: default to fetching active students
  #  default_scope :active

  def self.find_andrew_user search_string
    u = self.find_by_andrewid search_string
    u ||= self.find_or_create_by( andrewid: CarnegieMellonPerson.
                                  find_by_andrewid( search_string )[:cmuandrewid] )
  rescue ActiveLdap::EntryNotFound
  end

#  def self.find_or_create( andrewid )
#    CarnegieMellonPerson.find_by_andrewid andrewid
#    find_by_andrewid( andrewid ) || create( :andrewid => andrewid )
#  end
    
  
#  def completed_seminars
#    self.registrations.credited.collect(&:seminar)
#  end


 def is_administrator?
    self.is_admin == 1
 end

 def is_consultant?
   self.consultant == 1
 end

 scope :ffp_participants, -> (status) { where(:future_faculty_progress_status => Program::ProgressStatusType.find(status)) }
 
# def ffp_participants( status )
#   Participant.all
# end
 

#  def registration_for( seminar )
#    self.registrations.find_by_seminar_id( seminar.id )
#  end

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
    [ldap_reference["cmuDepartment"]].flatten.join(", ")
  end

  def departments
    ldap_reference["cmuDepartment"]
  end

  def college
    [ldap_reference["eduPersonSchoolCollegeName"]].flatten.join(", ")
  end

  def colleges
    ldap_reference["eduPersonSchoolCollegeName"]
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


  validates_presence_of :andrewid, message: "required"
  validates_uniqueness_of :andrewid, message: "already exists"
end
