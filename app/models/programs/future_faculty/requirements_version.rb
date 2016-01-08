class Programs::FutureFaculty::RequirementsVersion < ActiveRecord::Base
  has_many :requirements, class_name: Programs::FutureFaculty::Requirement,
           foreign_key: :future_faculty_requirements_version_id

  has_many :categories, -> { uniq }, through: :requirements, source: :requirement_category

  has_many :participants, foreign_key: :future_faculty_enrollment_id

  has_many :pending_graduates, -> { ffp_participants('complete') },
           class_name: Participant, foreign_key: :future_faculty_enrollment_id


  def calculate_participant_status( participant )

    # Participant must be enrolled in an ffp version to have a status
    unless participant.future_faculty_enrollment
      participant.future_faculty_progress_status = nil
      return
    end

    # Do not recalculate terminal states
    if participant.future_faculty_progress_status == Program::ProgressStatusType.find('dropout') ||
       participant.future_faculty_progress_status == Program::ProgressStatusType.find('graduated')
      return
    end

    # Calculate various requirements of the programs
    participant.future_faculty_progress_status =
      case participant.future_faculty_enrollment.key
      when "2015"
        if ( participant.attended_workshops.size + participant.attended_seminars.size >= 8 ) &&
           ( participant.attended_seminars.with_tag("core").size >= 4 ) &&
           ( ( participant.activities.where('completed_on is not null and type="Participant::Activities::TeachingObservation"').size >= 2 ) ||
             ( participant.activities.where('completed_on is not null and type="Participant::Activities::TeachingObservation"').size >= 1 &&
               participant.activities.where('completed_on is not null and type="Participant::Activities::EarlyCourseFeedback"').size >= 1 ) ||
             ( participant.activities.where('completed_on is not null and type="Participant::Activities::TeachingObservation"').size >= 1 &&
               participant.activities.where('completed_on is not null and type="Participant::Activities::MicroteachingWorkshop"').size >= 1 )
           ) &&
           ( participant.activities.where('completed_on is not null and type="Participant::Activities::CourseAndSyllabusDesignProject"').size >= 1 ) &&
           ( participant.activities.where('completed_on is not null and type="Participant::Activities::TeachingStatementProject"').size >= 1 )
          Program::ProgressStatusType.find('complete')
        else
          Program::ProgressStatusType.find('incomplete')
        end
      when "2012"
        # TODO: What are the old requirements?
        participant.future_faculty_progress_status
      else
        nil
      end # case
  end # calculate_participant_status


end
