class Participant < ActiveRecord::Base
  has_many :registrations
  has_many :seminars, :through => :registrations

  def is_administrator?
    self.is_admin == 1
  end

  def name
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    Array.[](person["cn"]).flatten.last
  end
  
  def email
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    person["mail"]
  end

  def department
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    person["cmuDepartment"]
  end

  def student_class
    person = CarnegieMellonPerson.find_by_andrewid( self.andrewid )
    person["cmuStudentClass"]
  end
end
