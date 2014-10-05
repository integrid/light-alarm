# == Schema Information
#
# Table name: alarms
#
#  id             :integer          not null, primary key
#  alarm_at       :time
#  delayed_job_id :integer
#  duration       :integer
#  created_at     :datetime
#  updated_at     :datetime
#

# TODO remove delayed_job_id
class Alarm < ActiveRecord::Base
  def trigger_alarm
    puts "ALARM!!!"
    Alarm.delete_all
  end

  def trigger_alarm_at
    time = Time.now.change(hour: alarm_at.hour, min: alarm_at.min)
    time += 1.day if time < Time.now
    time
  end
end
