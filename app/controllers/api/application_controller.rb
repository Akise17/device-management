class Api::ApplicationController < ApplicationController
  before_action :authenticate_api!

  private

  def authenticate_api!
    api_key = request.headers['X-Api-Key']
    raise ApiException::Unauthorized unless api_key == ENV['API_KEY']
  end
end
