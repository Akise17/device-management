class Api::V1::DeviceController < Api::ApplicationController
  def show
    device = Device.find_or_initialize_by(device_id: params[:id])
    raise ApiException::NotFound unless device.save

    render json: device
  end
end
