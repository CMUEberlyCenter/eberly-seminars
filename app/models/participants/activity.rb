class Participants::Activity < ActiveRecord::Base
#  self.table_name = "participants_activities"

  belongs_to :participant
  belongs_to :future_faculty_requirement

  validates :participant, presence: true
  validates_associated :participant
  
  validates_associated :future_faculty_requirement
end
