class AddFirstConsultationOnToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :first_consultation_on, :date
  end
end
