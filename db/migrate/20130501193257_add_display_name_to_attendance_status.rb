class AddDisplayNameToAttendanceStatus < ActiveRecord::Migration
  def self.up
    add_column :attendance_statuses, :display_name, :string
  end

  def self.down
    remove_column :attendance_statuses, :display_name, :string
  end

end
