class CreateParticipantActivities < ActiveRecord::Migration
  def change
    create_table :participants_activities do |t|
      t.references :participant, index: true
      t.string :type
      t.references :future_faculty_requirement, index: false
      t.string :course
      t.string :title
      t.string :description
      t.date :completed_on

      t.timestamps null: false
    end
    add_index :participants_activities, :future_faculty_requirement_id, name: 'index_participants_activities_on_ff_requirement_id'
    add_foreign_key :participants_activities, :participants
    add_foreign_key :participants_activities, :future_faculty_requirements
  end
end
