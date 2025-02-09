import pika
import ssl

# Amazon MQ credentials
RABBITMQ_USERNAME = "test"
RABBITMQ_PASSWORD = "test123456789"
BROKER_HOST = "rmq01.vprof"

# Use SSL for secure connection
context = ssl.create_default_context()
context.check_hostname = False  # Disable hostname verification
context.verify_mode = ssl.CERT_NONE  # Disable certificate verification (Not recommended for production)
ssl_options = pika.SSLOptions(context)

# Connect to RabbitMQ
connection_params = pika.ConnectionParameters(
    host=BROKER_HOST,
    port=5671,  # Use 5671 for AMQPS (secure)
    virtual_host="/",
    credentials=pika.PlainCredentials(RABBITMQ_USERNAME, RABBITMQ_PASSWORD),
    ssl_options=ssl_options
)

connection = pika.BlockingConnection(connection_params)

print( connection.is_open )
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
