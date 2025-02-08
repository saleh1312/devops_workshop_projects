
from pymemcache.client import base

# Connect to Memcached
client = base.Client(('mc01.vprof', 11211))

# Set a key-value pair
client.set('greeting', 'Hello, Memcached!')

# Retrieve the value
value = client.get('greeting')

# Print the value
print(f"Stored Value: {value.decode('utf-8')}")  # Decode from bytes to string

# Delete the key
client.delete('greeting')

# Try retrieving the deleted value
value_after_delete = client.get('greeting')
print(f"Value after deletion: {value_after_delete}")  # Should print None
