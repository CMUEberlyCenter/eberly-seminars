class RenameStatusInAttendanceStatus < ActiveRecord::Migration
  def change
    rename_column :attendance_statuses, :status, :key
    rename_column :attendance_statuses, :display_name, :label
  end
end
