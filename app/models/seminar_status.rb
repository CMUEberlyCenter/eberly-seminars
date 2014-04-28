class SeminarStatus < ActiveRecord::Base

  # So far no need for different/more verbose labels
  def label
    self.key.titlecase
  end

  # Useful alias for delegate method in Seminar model
  def status
    self.key
  end

end
