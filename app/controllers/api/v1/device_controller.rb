class Api::V1::DeviceController < Api::ApplicationController
  def show
    device = Device.find_by_device_id(params[:id])
    raise ApiException::NotFound if device.blank?

    render json: device
  end
end
