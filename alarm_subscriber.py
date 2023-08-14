import os
import paho.mqtt.client as mqtt
from dotenv import load_dotenv
from sqlalchemy import create_engine, Column, Integer, String, Float, DateTime, Boolean, func
from sqlalchemy.orm import declarative_base, sessionmaker
from sqlalchemy.dialects.postgresql import JSON

load_dotenv()
Base = declarative_base()
engine = create_engine(os.getenv('DATABASE_URL'))
Session = sessionmaker(bind=engine)

# MQTT broker settings
broker_host = os.getenv('MQTT_HOST')
broker_port = int(os.getenv('MQTT_PORT'))
broker_user = os.getenv('MQTT_USER')
broker_pass = os.getenv('MQTT_PASS')
topic = "alarm/#"

class Device(Base):
    __tablename__ = 'devices'
    id = Column(Integer, primary_key=True)
    device_id = Column(String)
    send_interval = Column(Integer)
    sensor_type = Column(String)
    device_type = Column(String)
    config = Column(JSON)
    alarm_state = Column(Boolean)

def update_device(device_id, data):
    try:
        session = Session()
        device = session.query(Device).filter_by(device_id = device_id).first()
        if device:
            device.alarm_state = data == "1"
            session.commit()
            session.close()
            return True
        else:
            print("Device not found.")
            return False

    except Exception as e:
        print("Error:", e)

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe(topic)

def on_message(client, userdata, msg):
    device_id = msg.topic.split("/")[1]
    data = msg.payload.decode()
    if update_device(device_id, data):
        print("Received message on topic: " + msg.topic)
        print("Message: " + msg.payload.decode())
        print("Succesfully Saved")
    else:
        print("Received message on topic: " + msg.topic)
        print("Message: " + msg.payload.decode())
        print("Save Failed")
    
# Main Program
print("Start alarm subscription")
client = mqtt.Client()

client.on_connect = on_connect
client.on_message = on_message

client.username_pw_set(broker_user, broker_pass)
client.connect(broker_host, broker_port, 60)
print("Client Connected")

client.loop_forever()
