class CreateMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :metrics do |t|
      t.string :device_id
      t.integer :raw_data
      t.float :readable_data
      t.string :unit
      t.timestamps
    end

    add_index :metrics, :device_id
    add_index :devices, :device_id
  end
end
