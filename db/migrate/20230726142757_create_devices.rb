class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.string :device_id
      t.integer :send_interval
      t.boolean :alarm_state, defaule: false
      t.string :sensor_type
      t.string :device_type
    end
  end
end
