class Device < ApplicationRecord
  attribute :config, :json, default: {}

  has_many :metrics, primary_key: 'device_id'

  # def config=(value)
  #   hash = JSON.parse(value)
  #   super(hash)
  # end
end
