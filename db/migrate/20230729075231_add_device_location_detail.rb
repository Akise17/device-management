class AddDeviceLocationDetail < ActiveRecord::Migration[7.0]
  def change
    add_column :devices, :location, :string
    add_column :devices, :location_url, :text
  end
end
