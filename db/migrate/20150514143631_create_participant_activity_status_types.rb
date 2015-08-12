class CreateParticipantActivityStatusTypes < ActiveRecord::Migration
  def change
    create_table :participant_activity_status_types do |t|
      t.references :future_faculty_requirement
      t.string :key
      t.string :label
      t.timestamps null: false
    end
    add_foreign_key :participant_activity_status_types, :future_faculty_requirements
  end
end
