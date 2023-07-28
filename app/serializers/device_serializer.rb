class DeviceSerializer < ActiveModel::Serializer
  attributes :device_id, :send_interval, :alarm_state,
             :sensor_type, :device_type

  attribute :broker do
    Setting['MQTT_HOST']
  end

  attribute :last_data do
    object.metrics.last.raw_data
  end
end
