class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.primary_key :id
      t.string :andrewid

      t.timestamps
    end
  end
end
