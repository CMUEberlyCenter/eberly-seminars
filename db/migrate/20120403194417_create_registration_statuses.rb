class CreateRegistrationStatuses < ActiveRecord::Migration
  def change
    create_table :registration_statuses do |t|
      t.primary_key :id
      t.string :registration_status

      t.timestamps
    end
  end
end
