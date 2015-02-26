class Programs::FutureFaculty::Enrollment

  def initialize( participant )
    # TODO: remove hardcoded key
    version = Programs::FutureFaculty::RequirementsVersion.find_by_key '2015'
    participant.future_faculty_enrollment = version
    participant.save!
  end

  def self.destroy( participant )
    # TODO: remove hardcoded key
    version = Programs::FutureFaculty::RequirementsVersion.find_by_key '2015'
    participant.activities.program_requirements(:future_faculty).destroy_all
    participant.future_faculty_enrollment = nil
    participant.save!
  end

  def self.find( participant )
    participant.future_faculty_enrollment
  end

end
