class Observation < ActiveRecord::Base
  belongs_to( :type, class_name: "ObservationType", 
              foreign_key: "observation_type_id")
  belongs_to :participant

  attr_accessible :course, :observed_on, :type, :observation_type_id

  def display_observed_on
    I18n.l self.observed_on, format: :prose
  end

  def display_type
    self.type.label
  end

  # Every observation must have at least a participant and
  # a type to get created
  validates :type, :participant, presence: true
  validates_associated :type
  validates_associated :participant
end
