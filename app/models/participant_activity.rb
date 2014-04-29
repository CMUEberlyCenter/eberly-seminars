class ParticipantActivity < ActiveRecord::Base
  belongs_to :participant
  attr_accessible :description, :title

  validates :participant, :title, presence: true
  validates_associated :participant
end
