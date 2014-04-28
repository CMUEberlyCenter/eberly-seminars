class Registration < ActiveRecord::Base
  belongs_to :participant
  belongs_to :seminar #, :through => :seminar_offering
  belongs_to :registration_status
  belongs_to :attendance_status

  delegate :status, :to => :registration_status, :prefix => false

  RegistrationStatus.all.each do |s| 
    scope s.status, :conditions => { :registration_status_id => s }
  end


  AttendanceStatus.all.each do |s| 
    scope s.status, :conditions => { :attendance_status_id => s }
  end

  scope :credited, self.confirmed.attended.joins(:seminar).where('end_at < ?', Time.now)

  scope :upcoming, joins(:seminar).where('end_at >= ?', Time.now)

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
