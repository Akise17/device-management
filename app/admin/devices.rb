ActiveAdmin.register Device do
  permit_params :device_id, :send_interval, :alarm_state, :sensor_type, :device_type

  DEVICE_TYPE_OPTIONS = {
    'Accelerometer' => 'accelerometer',
    'Rotary Encoder' => 'rotary_encoder',
    'Humidity' => 'humidity'
  }.freeze

  form do |f|
    f.inputs do
      f.input :device_id
      f.input :send_interval
      f.input :alarm_state
      f.input :sensor_type
      f.input :device_type, as: :select, collection: DEVICE_TYPE_OPTIONS
    end
    f.actions
  end
end
