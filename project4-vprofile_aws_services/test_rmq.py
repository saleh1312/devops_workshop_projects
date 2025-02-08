import pika
import ssl

# Amazon MQ credentials
RABBITMQ_USERNAME = "test"
RABBITMQ_PASSWORD = "test123456789"
BROKER_URL = "amqps://b-14b244d4-7a9d-49b5-9bd1-bfab831adc4f.mq.us-east-1.amazonaws.com"

# Use SSL for secure connection
context = ssl.create_default_context()
ssl_options = pika.SSLOptions(context)

# Connect to RabbitMQ
connection_params = pika.ConnectionParameters(
    host=BROKER_URL,
    port=5671,  # Use 5671 for AMQPS (secure)
    virtual_host="/",
    credentials=pika.PlainCredentials(RABBITMQ_USERNAME, RABBITMQ_PASSWORD),
    ssl_options=ssl_options
)

connection = pika.BlockingConnection(connection_params)
channel = connection.channel()

# Declare a queue
queue_name = "test_queue"
channel.queue_declare(queue=queue_name)

# Publish a message
message = "Hello, Amazon MQ from EC2!"
channel.basic_publish(exchange='', routing_key=queue_name, body=message)
print(f" [x] Sent '{message}'")

# Close connection
connection.close()
