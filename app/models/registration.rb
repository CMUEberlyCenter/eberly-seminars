class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :seminar
  belongs_to :registration_status
  belongs_to :attendance_status
end
