class Participant < ActiveRecord::Base
  has_many :registrations
  has_many :seminars, :through => :registrations

  def is_administrator?
    self.is_admin == 1
  end

  def registration_for( seminar )
    self.registrations.find_by_seminar_id( seminar.id )
  end

  def name
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    Array.[](person["cn"]).flatten.last
  end
  
  def email
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    person["mail"]
  end

  def department
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    person["cmuDepartment"]
  end

  def student_class
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    person["cmuStudentClass"]
  end

  def request_registration( seminar )
    status = RegistrationStatus.find_by_status( 'pending' )
    registration = self.registrations.build( :seminar_id => seminar, :registration_status => status )
    registration.save
    ParticipantMailer.pending_registration_email( self, registration ).deliver
  end

  def cancel_registration( registration )
    self.registrations.find( registration ).destroy
  end

end
