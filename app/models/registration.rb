class Registration < ActiveRecord::Base

  # Participant
  belongs_to :participant


  # Event Information
  belongs_to :seminar
  [:description, :title, :start_at, :end_at, :location].each do |m|
    delegate m, to: :seminar, prefix: :event
  end

  
  # Registration Status
  delegate :status, :to => :registration_status
  belongs_to :registration_status
  
  RegistrationStatus.find_each do |s| 
    scope s.status, -> { where( registration_status: s ) }
  end

  
  # Attendance Status
  belongs_to :attendance_status
  
  AttendanceStatus.find_each do |s| 
    scope s.status, -> { where( attendance_status: s ).
                         joins( :seminar ).
                         merge( Seminar.completed ) }
  end



#  scope :has_tag, -> (tag) { joins(:seminar_tags).where("seminar_tags.value = ?", tag) }
  scope :credited, -> { merge(:confirmed).merge(:attended).where( 'end_at < ?', Time.now ) }
  #
  
#  scope :credited, -> { self.confirmed.attended.joins(:seminar).where( 'end_at < ?', Time.now ) }

#  scope :credited, -> { joins(:seminar) & (:registration_).where( 'end_at < ?', Time.now )
  scope :upcoming, -> { joins(:seminar).where('end_at >= ?', Time.now) }

  validates :participant, :presence => true
  validates_uniqueness_of :participant_id, :scope => [:seminar_id]

  def confirmed?
    self.status == RegistrationStatus.find_by_key('confirmed').key
  end

  def pending?
    self.status == RegistrationStatus.find_by_key('pending').key
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
