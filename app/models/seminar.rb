class Seminar < ActiveRecord::Base
  belongs_to :seminar_status

  SeminarStatus.all.each { |s| scope s.seminar_status, :conditions => { :seminar_status_id => s } }
  scope :active, :conditions => ["end_at >= ?", Time.now]
end
