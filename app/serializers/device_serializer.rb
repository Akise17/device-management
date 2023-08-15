class DeviceSerializer < ActiveModel::Serializer
  attributes :device_id, :send_interval, :alarm_state,
             :sensor_type, :device_type

  attribute :broker do
    Setting['MQTT_HOST']
  end

  attribute :last_data do
    object.metrics&.last&.raw_data || 0
  end

  attribute :current_time do
    DateTime.now.in_time_zone('Asia/Makassar').strftime('%d-%m-%y-%H-%M-%S')
  end
end
