class AddFutureFacultyProgramGraduatedOnToParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :future_faculty_program_graduated_on, :date
  end
end
