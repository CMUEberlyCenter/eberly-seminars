class AddLeadConsultantToParticipantActivity < ActiveRecord::Migration
  def change
    add_reference :participant_activities, :lead_consultant, index: true, after: :observer_id
    add_foreign_key :participant_activities, :participants, column: :lead_consultant_id
  end
end
