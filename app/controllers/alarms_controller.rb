class AlarmsController < ApplicationController
  # GET /alarm
  def show
    @alarm = Alarm.all.first
  end

  # POST /alarm
  def create
    raise "Alarm already exists!" if Alarm.count > 0
    alarm = Alarm.create!(params[:alarm].permit(:alarm_at, :duration))
    alarm.delay(run_at: alarm.trigger_alarm_at).trigger_alarm
    redirect_to alarm_path
  end

  # DELETE /alarm
  def destroy
    raise "No alarm exists!" if Alarm.count == 0
    Alarm.first.delete
    Delayed::Job.delete_all
    redirect_to alarm_path
  end
end
