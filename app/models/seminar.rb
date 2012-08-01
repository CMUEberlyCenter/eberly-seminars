class Seminar < ActiveRecord::Base
  belongs_to :seminar_status
  has_many :registrations
  delegate :status, :to => :seminar_status, :prefix => false
  accepts_nested_attributes_for :registrations, :allow_destroy => true

  SeminarStatus.all.each do |s|
    scope s.status, :conditions => { :seminar_status_id => s }
  end
  scope :active, :conditions => ["end_at >= ?", Time.now]
  scope :expired, :conditions => ["end_at <= ?", Time.now]

  # TODO: filter for current semester regardless of publish status
  scope :current_semester, :conditions => []

  validates :title, :presence => true

  #named_scope :confirmed, lambda {|participant| {:conditions => {:author_id => author.id}}}


  def status=(status)
    self.seminar_status=(status)
  end


  def registration_for( participant )
    self.registrations.select{ |r| r.participant == participant }.first
    
  end


  
  def confirmed_count
    self.registrations.confirmed.size
  end

  def capacity_percentage
    (self.confirmed_count.to_f/self.maximum_capacity*100).to_i
  end

  def formatted_timespan
    start_format = "%A, %B %e, %l:%M"
    end_format = ""
    if self.start_at.to_date == self.end_at.to_date
      end_format = "%-l:%M%P"
      unless (self.start_at.hour < 12 and self.end_at.hour < 12) or
          (self.start_at.hour >= 12 and self.end_at.hour >= 12)
        start_format = start_format + "%P"
      end
    else
      start_format = start_format + "%P "
      end_format = " " + start_format
    end

    self.start_at.strftime(start_format) + "&ndash;" + self.end_at.strftime(end_format)
  end

  def semester
    "F12"
  end

  #validate :expiration_date_cannot_be_in_the_past,
  #  :discount_cannot_be_greater_than_total_value
 
  #def expiration_date_cannot_be_in_the_past
  #  if !expiration_date.blank? and expiration_date < Date.today
  #    errors.add(:expiration_date, "can't be in the past")
  #  end

end

