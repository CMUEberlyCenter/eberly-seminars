class ParticipantActivity::Additional < ParticipantActivity::Base
  belongs_to :participant

  attr_accessible :description, :title

  validates :title, presence: true
end
