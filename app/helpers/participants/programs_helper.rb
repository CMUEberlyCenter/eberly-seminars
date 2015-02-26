module Participants::ProgramsHelper

  def hide_if_unenrolled( participant, program )
    "display: none;" unless "Programs::#{program.to_s.classify}::Enrollment".constantize.find(participant)
  end
  
end
