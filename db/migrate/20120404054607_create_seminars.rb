class CreateSeminars < ActiveRecord::Migration
  def change
    create_table :seminars do |t|
      t.primary_key :id
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.references :seminar_status
      t.integer :maximum_capacity
      t.integer :participants_confirmed_cache
      t.string :location

      t.timestamps
    end
    add_index :seminars, :seminar_status_id
  end
end
