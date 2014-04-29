class AddInFutureFacultyToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :in_future_faculty, :boolean
  end
end
