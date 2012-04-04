class CreateAttendanceStatuses < ActiveRecord::Migration
  def change
    create_table :attendance_statuses do |t|
      t.primary_key :id
      t.string :attendance_status

      t.timestamps
    end
  end
end
