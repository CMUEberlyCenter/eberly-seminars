class RenameStatusInRegistrationStatus < ActiveRecord::Migration
  def change
    rename_column :registration_statuses, :status, :key
  end
end
