from flask import Flask, request
import json

app = Flask(__name__)

# In-memory storage for sensor data (for simplicity)
sensor_data = {}

@app.route('/data', methods=['POST'])
def receive_data():
    # Receive sensor data from ESP32
    data = request.get_json()
    print("Received Data:", data)
    
    # Store received data
    sensor_data['distance'] = data['distance']
    
    # Example of threshold check (simple overspeed check)
    if data['distance'] < 10:  # Assuming 10 is the threshold for obstacle detection
        send_alert("Obstacle detected!")
    
    return "Data received", 200

def send_alert(message):
    # Send an alert (could be an email, SMS, or push notification)
    print("Alert:", message)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
