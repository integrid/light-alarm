class CreateAlarms < ActiveRecord::Migration
  def change
    create_table :alarms do |t|
      t.time :alarm_at
      t.integer :delayed_job_id
      t.integer :duration

      t.timestamps
    end
  end
end
