class AddInternalNotesToParticipantActivities < ActiveRecord::Migration
  def change
    add_column :participant_activities, :internal_notes, :string
  end
end
