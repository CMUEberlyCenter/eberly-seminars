class AddConsultantToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :consultant, :boolean, after: :is_admin, default: 0
  end
end
