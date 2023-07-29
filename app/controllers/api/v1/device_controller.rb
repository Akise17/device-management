class Api::V1::DeviceController < Api::ApplicationController
  skip_before_action :authenticate_api!, only: %i[setting]
  def show
    device = Device.find_by_device_id(params[:id])
    raise ApiException::NotFound if device.blank?

    render json: device
  end

  def create
    device = Device.find_or_initialize_by(device_id: params[:device_id])
    raise ApiException::BadRequest unless device.update(device_params)

    render json: device
  end

  def setting
    Mqtt.publish("setting/#{params[:device_id]}/#{params[:command]}")
    redirect_to root_path
  end

  private

  def device_params
    params.permit(:device_id,
                  :send_interval,
                  :alarm_state,
                  :sensor_type,
                  :device_type,
                  config: {})
  end
end
