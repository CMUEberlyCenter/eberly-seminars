class CreateSeminarStatuses < ActiveRecord::Migration
  def change
    create_table :seminar_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
