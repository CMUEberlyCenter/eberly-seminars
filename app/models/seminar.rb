class Seminar < ActiveRecord::Base
  belongs_to :seminar_status
  
  delegate :status, :to => :seminar_status, :prefix => false

  SeminarStatus.all.each { |s| scope s.status, :conditions => { :seminar_status_id => s } }
  scope :active, :conditions => ["end_at >= ?", Time.now]
end
