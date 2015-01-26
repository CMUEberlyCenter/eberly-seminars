class CreateFutureFacultyRequirements < ActiveRecord::Migration
  def change
    create_table :future_faculty_requirements do |t|
      t.string :key
      t.string :label
      t.references :future_faculty_requirements_version, index: false
      t.references :future_faculty_requirement_category, index: false
      t.string :activity_class

      t.timestamps null: false
    end
    add_index :future_faculty_requirements, :future_faculty_requirements_version_id, name: 'index_ff_requirements_on_ff_requirements_version_id'
    add_index :future_faculty_requirements, :future_faculty_requirement_category_id, name: 'index_ff_requirements_on_ff_requirement_category_id'
    add_foreign_key :future_faculty_requirements, :future_faculty_requirements_versions
    add_foreign_key :future_faculty_requirements, :future_faculty_requirement_categories
  end
end
