class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.references :participant
      t.references :observation_type
      t.string :course
      t.date :observed_on

      t.timestamps
    end
    add_index :observations, :observation_type_id
    add_index :observations, :participant_id
  end
end
