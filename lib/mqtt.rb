module Mqtt
  class << self
    def publish(topic)
      mqtt_url = "mqtt://#{ENV['MQTT_USER']}:#{ENV['MQTT_PASS']}@#{ENV['MQTT_HOST']}:#{ENV['MQTT_PORT']}"
      client = MQTT::Client.connect(mqtt_url)
      puts mqtt_url
      client.publish(topic, 1, false)
      client.disconnect
    end
  end
end
