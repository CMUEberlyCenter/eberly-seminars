class CreateAttendanceStatuses < ActiveRecord::Migration
  def change
    create_table :attendance_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
