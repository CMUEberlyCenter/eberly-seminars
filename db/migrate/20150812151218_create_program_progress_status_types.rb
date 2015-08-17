class CreateProgramProgressStatusTypes < ActiveRecord::Migration
  def change
    create_table :program_progress_status_types do |t|
      t.string :key
      t.string :label

      t.timestamps null: false
    end
  end
end
