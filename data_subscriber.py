import os
import paho.mqtt.client as mqtt
from dotenv import load_dotenv
from sqlalchemy import create_engine, Column, Integer, String, Float, DateTime, func
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
topic = "data/#"

class Device(Base):
    __tablename__ = 'devices'
    id = Column(Integer, primary_key=True)
    device_id = Column(String)
    send_interval = Column(Integer)
    sensor_type = Column(String)
    device_type = Column(String)
    config = Column(JSON)

class Metric(Base):
    __tablename__ = 'metrics'
    id = Column(Integer, primary_key=True)
    device_id = Column(String)
    raw_data = Column(Integer)
    readable_data = Column(Float)
    unit = Column(String)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())

def get_device(device_id):
    try:
        session = Session()
        device = session.query(Device).filter_by(device_id = device_id).first()
        session.close()
        return device

    except Exception as e:
        print("Error:", e)

def save_metric(device_id, data):
    try:
        device = get_device(device_id)
        readable_data = getattr(Calculation(), device.device_type)(data, device.config)

        session = Session()
        new_data = Metric(
            device_id=device_id,
            raw_data=data,
            readable_data=readable_data,
            unit=device.config["unit"]
        )
        session.add(new_data)
        session.commit()
        session.close()
        return True
        
    except Exception as e:
        print("Error:", e)
        return False

def on_connect(client, userdata, flags, rc):
    print("Connected with result code " + str(rc))
    client.subscribe(topic)

def on_message(client, userdata, msg):
    device_id = msg.topic.split("/")[1]
    data = msg.payload.decode()
    if save_metric(device_id, data):
        print("Received message on topic: " + msg.topic)
        print("Message: " + msg.payload.decode())
        print("Succesfully Saved")
    else:
        print("Received message on topic: " + msg.topic)
        print("Message: " + msg.payload.decode())
        print("Save Failed")

class Calculation:
    def rotary_encoder(self, *args):
        raw_data = float(args[0])
        config = args[1]
        circumference = 2 * (22/7) * (config["diameter"]/2)
        return (circumference / config["step"]) * raw_data

    
# Main Program
while True:
    print("Start data subscription")
    client = mqtt.Client("", True, None, mqtt.MQTTv31)

    client.on_connect = on_connect
    client.on_message = on_message

    client.username_pw_set(broker_user, broker_pass)
    client.connect(broker_host, broker_port, 60)
    print("Client Connected")
    print("mqtt://" + broker_user + ":" + broker_pass + "@" + broker_host + ":" + broker_pass)

    try:
        client.loop_forever()
    except:
        print("Disconnected try to reconnect")
