class AddDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column :devices, :send_interval, :integer, default: 5
    change_column :devices, :alarm_state, :boolean, default: false
  end
end
