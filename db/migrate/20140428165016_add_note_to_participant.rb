class AddNoteToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :note, :text
  end
end
