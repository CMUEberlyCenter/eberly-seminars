class CreateFutureFacultyRequirementCategories < ActiveRecord::Migration
  def change
    create_table :future_faculty_requirement_categories do |t|
      t.string :key
      t.string :label

      t.timestamps null: false
    end
  end
end
