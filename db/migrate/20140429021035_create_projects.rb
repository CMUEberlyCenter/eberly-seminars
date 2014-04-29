class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :participant
      t.references :project_type
      t.references :project_status
      t.text :description

      t.timestamps
    end
    add_index :projects, :participant_id
    add_index :projects, :project_type_id
    add_index :projects, :project_status_id
  end
end
