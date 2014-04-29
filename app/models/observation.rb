class Observation < ActiveRecord::Base
  belongs_to( :type, class_name: "ObservationType", 
              foreign_key: "observation_type_id", readonly: true )
  belongs_to :participant

  attr_accessible :course, :observed_on, :type

  # Every observation must have at least a participant and
  # a type to get created
  validates :type, :participant, presence: true
  validates_associated :type
  validates_associated :participant
end
