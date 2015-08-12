class AddStatusToParticipantActivity < ActiveRecord::Migration
  def change
    add_reference :participant_activities, :status, index: true, after: "future_faculty_requirement_id"
    add_foreign_key :participant_activities, :participant_activity_status_types, column: "status_id"
  end
end
