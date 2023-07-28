ActiveAdmin.register Device do
  permit_params :device_id, :send_interval, :alarm_state, :sensor_type, :device_type, :config

  json_editor
  DEVICE_TYPE_OPTIONS = { 'Accelerometer' => 'accelerometer',
                          'Rotary Encoder' => 'rotary_encoder',
                          'Humidity' => 'humidity' }.freeze

  form do |f|
    f.inputs do
      f.input :device_id
      f.input :send_interval
      f.input :alarm_state
      f.input :sensor_type
      f.input :device_type, as: :select, collection: DEVICE_TYPE_OPTIONS
      f.input :config, as: :json
    end
    f.actions
  end

  controller do
    def create
      @device = Device.new(permitted_params[:device])
      super
    end

    def update
      @device = Device.find(params[:id])
      @device.assign_attributes(permitted_params[:device])
      super
    end
  end
end
