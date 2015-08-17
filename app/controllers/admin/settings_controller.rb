class Admin::SettingsController < ApplicationController
  before_filter :require_administrator

  def index
    @settings = Setting.all
    @consultants = Participant.where(consultant: true)
    @pending_graduates = Programs::FutureFaculty::RequirementsVersion.last.pending_graduates
    @unassigned_activities =  Participant::Activity.all.where("future_faculty_requirement_id > 6").where("observer_id is null")
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
