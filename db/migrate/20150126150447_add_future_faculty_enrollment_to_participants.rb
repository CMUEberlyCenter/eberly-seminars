class AddFutureFacultyEnrollmentToParticipants < ActiveRecord::Migration
  def change
    add_reference :participants, :future_faculty_enrollment, index: true
    add_foreign_key :participants, :future_faculty_requirements_versions, column: :future_faculty_enrollment_id
  end
end
