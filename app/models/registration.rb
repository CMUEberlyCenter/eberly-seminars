class Registration < ActiveRecord::Base
  belongs_to :participant
  belongs_to :seminar
  belongs_to :registration_status
  belongs_to :attendance_status

  delegate :status, :to => :registration_status, :prefix => false

  RegistrationStatus.all.each do |s| 
    scope s.status, :conditions => { :registration_status_id => s }
  end

  #named_scope :seminars, lambda {|seminar| {:conditions => {:seminar_id => author.id}}}
  #scope :upcoming, lambda {|registration| registration.seminar.end_at > Time.now }
  scope :upcoming, joins(:seminar).where('end_at >= ?', Time.now)
  #scope :upcoming, seminar.end_at > Time.now

  validates :participant, :presence => true
  validates_uniqueness_of :participant_id, :scope => [:seminar_id]

  def perform_registration
  end

  def confirmed?
    self.status == RegistrationStatus.find_by_status('confirmed').status
  end

  def pending?
    self.status == RegistrationStatus.find_by_status('pending').status
  end

  def search_string
  end

  def search_string=(search)
    participant=Participant.find_by_andrewid(search)
    CarnegieMellonPerson.find_by_andrewid(search)

    participant||=Participant.new(:andrewid =>search, :is_admin => false)
    participant.save!
    self.participant_id = Participant.find_by_andrewid(search).id
    #self.participant_id=64
    
  end

end
