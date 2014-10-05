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

require 'test_helper'

class AlarmTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
