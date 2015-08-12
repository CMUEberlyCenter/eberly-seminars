class Participant::Activities::Additional < Participant::Activity
#  attr_accessible :description, :title

  validates :title, presence: true
end
