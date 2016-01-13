class Admin::SettingsController < ApplicationController
  before_filter :require_administrator

  def index
    @settings = Setting.all
    @consultants = Participant.where(consultant: true)
    @pending_graduates = Programs::FutureFaculty::RequirementsVersion.find_each.map { |x| x.pending_graduates }.flatten
    @nudges = Participant::Activity.all.where("type='Participant::Activities::MicroteachingWorkshop' or type='Participant::Activities::EarlyCourseFeedback' or type='Participant::Activities::TeachingObservation'").where("memo_completed_on is null").where("completed_on < ?",3.weeks.ago).order(:completed_on)
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
