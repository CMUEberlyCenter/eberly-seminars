class SeminarTag < ActiveRecord::Base
  belongs_to :seminar
  attr_accessible :value, :seminar_id
end
