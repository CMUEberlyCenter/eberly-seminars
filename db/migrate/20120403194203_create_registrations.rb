class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.primary_key :id
      t.references :user
      t.references :seminar
      t.references :registration_status
      t.references :attendance_status

      t.timestamps
    end
    add_index :registrations, :user_id
    add_index :registrations, :seminar_id
    add_index :registrations, :registration_status_id
    add_index :registrations, :attendance_status_id
  end
end
