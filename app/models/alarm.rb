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

# TODO remove delayed_job_id (there should only be one in existence anyways)
class Alarm < ActiveRecord::Base
  def trigger_alarm
    time = self.duration.to_s
    case time.length
      when 2 then time = "0#{time}"
      when 1 then time = "00#{time}"
    end
    Arduino::send_message("trigger000000255#{time}")
    Alarm.delete_all  # TODO rethink delete location
  end

  def trigger_alarm_at
    time = Time.now.change(hour: alarm_at.hour, min: alarm_at.min)
    time += 1.day if time < Time.now
    time
  end
end
