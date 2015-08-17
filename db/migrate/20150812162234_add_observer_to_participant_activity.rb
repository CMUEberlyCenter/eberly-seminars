class AddObserverToParticipantActivity < ActiveRecord::Migration
  def change
    add_reference :participant_activities, :observer, index: true, after: :description
    add_foreign_key :participant_activities, :participants, column_name: :observer_id
  end
end
