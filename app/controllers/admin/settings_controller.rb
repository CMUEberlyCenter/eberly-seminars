class Admin::SettingsController < ApplicationController
  before_filter :require_administrator

  def index
    @settings = Setting.all
  end

  def update
    setting = Setting.find params[:id]
    setting.update_attributes params[:setting]
    setting.save
    redirect_to action: 'index'
  end

end
