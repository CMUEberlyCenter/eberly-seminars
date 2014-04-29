class CreateProjectTypes < ActiveRecord::Migration
  def change
    create_table :project_types do |t|
      t.string :key
      t.string :label

      t.timestamps
    end
  end
end
