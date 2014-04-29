class CreateProjectStatuses < ActiveRecord::Migration
  def change
    create_table :project_statuses do |t|
      t.string :key
      t.string :label

      t.timestamps
    end
  end
end
