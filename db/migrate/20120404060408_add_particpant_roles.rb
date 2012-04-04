class AddParticpantRoles < ActiveRecord::Migration
  def up
    add_column :participants, :is_admin, :boolean, :default => 0
  end

  def down
    remove_column :participants, :is_admin
  end
end
