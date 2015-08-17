class AddMemoCompletedOnToParticipantActivities < ActiveRecord::Migration
  def change
    add_column :participant_activities, :memo_completed_on, :date
  end
end
