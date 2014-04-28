class RenameStatusInSeminarStatus < ActiveRecord::Migration
  def change
    rename_column :seminar_statuses, :status, :key
  end
end
