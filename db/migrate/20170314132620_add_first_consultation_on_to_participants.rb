class AddFirstConsultationOnToParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :first_consultation_on, :date
  end
end
