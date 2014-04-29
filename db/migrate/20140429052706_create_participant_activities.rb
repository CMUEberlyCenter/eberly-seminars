class CreateParticipantActivities < ActiveRecord::Migration
  def change
    create_table :participant_activities do |t|
      t.references :participant
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :participant_activities, :participant_id
  end
end
