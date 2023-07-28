class CreateSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :settings do |t|
      t.string :name
      t.string :value
      t.string :value_type
      t.text :description
    end

    Setting.create(name: 'MQTT_HOST',
                   value: '192.168.1.1',
                   value_type: 'String')
  end
end
