class Participants::Activities::Additional < Participants::Activity
  attr_accessible :description, :title

  validates :title, presence: true
end
