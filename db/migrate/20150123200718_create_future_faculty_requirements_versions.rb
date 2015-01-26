class CreateFutureFacultyRequirementsVersions < ActiveRecord::Migration
  def change
    create_table :future_faculty_requirements_versions do |t|
      t.string :key
      t.string :label

      t.timestamps null: false
    end
  end
end
