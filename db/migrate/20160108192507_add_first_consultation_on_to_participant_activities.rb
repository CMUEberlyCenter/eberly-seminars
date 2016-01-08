class AddFirstConsultationOnToParticipantActivities < ActiveRecord::Migration
  def change
    add_column :participant_activities, :first_consultation_on, :date
    add_index :participant_activities, :first_consultation_on
  end
end
