class CreateObservationTypes < ActiveRecord::Migration
  def change
    create_table :observation_types do |t|
      t.string :key
      t.string :label

      t.timestamps
    end
  end
end
