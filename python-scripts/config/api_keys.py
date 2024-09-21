import os
from cryptography.fernet import Fernet
import json
import base64
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class APIKeyManager:
    def __init__(self, key_file='api_keys.json', encryption_key=None):
        self.key_file = key_file
        if encryption_key:
            self.fernet = Fernet(encryption_key)
        else:
            self.fernet = None
        self.keys = self.load_keys()

    def load_keys(self):
        if os.path.exists(self.key_file):
            with open(self.key_file, 'r') as f:
                encrypted_data = json.load(f)
            if self.fernet:
                decrypted_data = {k: self.fernet.decrypt(v.encode()).decode() for k, v in encrypted_data.items()}
                return decrypted_data
            else:
                return encrypted_data
        return {}

    def save_keys(self):
        if self.fernet:
            encrypted_data = {k: self.fernet.encrypt(v.encode()).decode() for k, v in self.keys.items()}
        else:
            encrypted_data = self.keys
        with open(self.key_file, 'w') as f:
            json.dump(encrypted_data, f, indent=2)

    def get_key(self, provider):
        return self.keys.get(provider)

    def set_key(self, provider, key):
        self.keys[provider] = key
        self.save_keys()
        logger.info(f"API key for {provider} has been set.")

    def delete_key(self, provider):
        if provider in self.keys:
            del self.keys[provider]
            self.save_keys()
            logger.info(f"API key for {provider} has been deleted.")
        else:
            logger.warning(f"No API key found for {provider}.")

    def list_providers(self):
        return list(self.keys.keys())

def generate_encryption_key():
    return base64.urlsafe_b64encode(os.urandom(32))

# Example usage
if __name__ == "__main__":
    # Generate a new encryption key (in practice, you'd want to securely store and reuse this key)
    encryption_key = generate_encryption_key()
    print(f"Generated encryption key: {encryption_key.decode()}")

    # Initialize the API Key Manager with encryption
    key_manager = APIKeyManager(encryption_key=encryption_key)

    # Set some API keys
    key_manager.set_key('aws', 'aws_api_key_12345')
    key_manager.set_key('azure', 'azure_api_key_67890')
    key_manager.set_key('gcp', 'gcp_api_key_abcde')

    # List all providers
    print("Providers with API keys:", key_manager.list_providers())

    # Get a specific API key
    print("AWS API Key:", key_manager.get_key('aws'))

    # Delete an API key
    key_manager.delete_key('azure')

    # Try to get the deleted key
    print("Azure API Key (should be None):", key_manager.get_key('azure'))

    # List providers again
    print("Providers after deletion:", key_manager.list_providers())