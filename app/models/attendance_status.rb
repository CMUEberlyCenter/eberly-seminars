class AttendanceStatus < ActiveRecord::Base

  # Useful alias for delegate method in Registration model
  def status
    self.key
  end

end
