class Project < ActiveRecord::Base
  belongs_to :participant
  belongs_to( :type, class_name: "ProjectType",
              foreign_key: "project_type_id")
  belongs_to( :status, class_name: "ProjectStatus",
              foreign_key: "project_status_id") #, readonly: true )
  attr_accessible :description, :type, :status, :project_type_id, :project_status_id

  # Type scope, e.g.: participant.projects.individual, Project.individual
  ProjectType.all.each do |type|
    scope type.key, -> { where( project_type_id: type ) }
  end

  # Status scope, e.g.: participant.projects.completed, Project.completed
  ProjectStatus.all.each do |status|
    scope status.key, -> { where( project_status_id: status ) }
  end

  def display_type
    self.type.label
  end

  def display_status
    self.status.label
  end


  # Every project must have at least a participant, type, and
  # status to get created
  validates :type, :participant, presence: true
  validates_associated :type
  # validates_associated :status
  validates_associated :participant

end
