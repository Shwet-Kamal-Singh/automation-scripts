from cryptography.fernet import Fernet
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.backends import default_backend
import base64
import os

class EncryptionManager:
    def __init__(self, key_file='encryption_key.key'):
        self.key_file = key_file
        self.key = self.load_or_generate_key()
        self.fernet = Fernet(self.key)

    def load_or_generate_key(self):
        if os.path.exists(self.key_file):
            with open(self.key_file, 'rb') as key_file:
                return key_file.read()
        else:
            key = Fernet.generate_key()
            with open(self.key_file, 'wb') as key_file:
                key_file.write(key)
            return key

    def encrypt_string(self, plaintext):
        return self.fernet.encrypt(plaintext.encode()).decode()

    def decrypt_string(self, ciphertext):
        return self.fernet.decrypt(ciphertext.encode()).decode()

    def encrypt_file(self, file_path):
        with open(file_path, 'rb') as file:
            data = file.read()
        encrypted_data = self.fernet.encrypt(data)
        with open(file_path + '.encrypted', 'wb') as file:
            file.write(encrypted_data)

    def decrypt_file(self, encrypted_file_path):
        with open(encrypted_file_path, 'rb') as file:
            encrypted_data = file.read()
        decrypted_data = self.fernet.decrypt(encrypted_data)
        original_file_path = encrypted_file_path.rsplit('.', 1)[0]
        with open(original_file_path, 'wb') as file:
            file.write(decrypted_data)

    @staticmethod
    def generate_key_from_password(password, salt=None):
        if salt is None:
            salt = os.urandom(16)
        kdf = PBKDF2HMAC(
            algorithm=hashes.SHA256(),
            length=32,
            salt=salt,
            iterations=100000,
            backend=default_backend()
        )
        key = base64.urlsafe_b64encode(kdf.derive(password.encode()))
        return key, salt

    def change_key(self, new_key):
        self.key = new_key
        self.fernet = Fernet(self.key)
        with open(self.key_file, 'wb') as key_file:
            key_file.write(self.key)

# Example usage
if __name__ == "__main__":
    em = EncryptionManager()

    # String encryption/decryption
    secret_message = "This is a secret message."
    encrypted_message = em.encrypt_string(secret_message)
    print(f"Encrypted: {encrypted_message}")
    decrypted_message = em.decrypt_string(encrypted_message)
    print(f"Decrypted: {decrypted_message}")

    # File encryption/decryption
    with open('test_file.txt', 'w') as f:
        f.write("This is a test file for encryption.")
    
    em.encrypt_file('test_file.txt')
    em.decrypt_file('test_file.txt.encrypted')

    # Generate key from password
    password = "my_secure_password"
    key, salt = EncryptionManager.generate_key_from_password(password)
    print(f"Generated key: {key}")

    # Change encryption key
    new_key = Fernet.generate_key()
    em.change_key(new_key)
    print("Encryption key changed.")