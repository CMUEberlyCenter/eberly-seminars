class ParticipantActivity::ClassroomObservation < ParticipantActivity::Base
  belongs_to :future_faculty_requirement
  belongs_to :participant
end
