class CreateSeminarTags < ActiveRecord::Migration
  def change
    create_table :seminar_tags do |t|
      t.references :seminar
      t.string :value

      t.timestamps
    end
    add_index :seminar_tags, :seminar_id
  end
end
