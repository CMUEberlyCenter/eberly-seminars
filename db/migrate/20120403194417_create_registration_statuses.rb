class CreateRegistrationStatuses < ActiveRecord::Migration
  def change
    create_table :registration_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
