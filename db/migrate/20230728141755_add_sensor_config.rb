class AddSensorConfig < ActiveRecord::Migration[7.0]
  def change
    add_column :devices, :config, :json
  end
end
