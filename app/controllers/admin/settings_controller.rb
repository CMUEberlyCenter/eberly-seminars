class Admin::SettingsController < ApplicationController
  before_filter :require_administrator

  def index
    @settings = Setting.all
    @consultants = Participant.where(consultant: true)
    @pending_graduates = Programs::FutureFaculty::RequirementsVersion.last.pending_graduates
    @nudges = Participant::Activity.all.where("type='Participant::Activities::MicroteachingWorkshop' or type='Participant::Activities::EarlyCourseFeedback' or type='Participant::Activities::TeachingObservation'").where("memo_completed_on is null").where("completed_on < ?",3.weeks.ago)
  end

  def update
    setting = Setting.find params[:id]
    setting.update_attributes setting_params
    setting.save
    redirect_to action: 'index'
  end

  private
  def setting_params
    if current_user.is_admin?
      params.require(:setting).permit(:value)
    end
  end

end
