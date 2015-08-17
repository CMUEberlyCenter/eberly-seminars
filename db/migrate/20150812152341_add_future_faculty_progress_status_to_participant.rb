class AddFutureFacultyProgressStatusToParticipant < ActiveRecord::Migration
  def change
    add_reference :participants, :future_faculty_progress_status, index: true
    add_foreign_key :participants, :program_progress_status_types, column: :future_faculty_progress_status_id, after: :future_faculty_requirement
  end
end
