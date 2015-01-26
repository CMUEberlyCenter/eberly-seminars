class RemoveInFutureFacultyFromParticipants < ActiveRecord::Migration
  def change
    remove_column :participants, :in_future_faculty, :boolean
  end
end
