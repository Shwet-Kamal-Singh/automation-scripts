# Configuration Management

This directory contains scripts for managing configuration settings and API keys for the cloud management system.

## Files

- `api_keys.py`: Manages API keys with encryption support
- `global_settings.py`: Manages global configuration settings
- `main.py`: Integrates settings and API key management with cloud resource management

## API Keys Management (`api_keys.py`)

Features:
- Encryption using the `cryptography` library
- File-based storage in JSON format
- Methods to set, get, and delete keys for different providers
- Provider listing
- Encryption key generation

Setup:
```
pip install cryptography
```

Usage:
```python
from api_keys import APIKeyManager

manager = APIKeyManager('path/to/keyfile.json', encryption_key)
manager.set_key('aws', 'your-aws-key')
aws_key = manager.get_key('aws')
```

## Global Settings Management (`global_settings.py`)

Features:
- File-based storage in JSON format
- Environment variable support
- Default values for settings
- CRUD operations for individual settings
- Bulk operations for listing and updating settings
- Automatic saving
- Logging

Usage:
```python
from global_settings import GlobalSettings

settings = GlobalSettings('global_settings.json')
settings.set('aws_region', 'us-west-2')
aws_region = settings.get('aws_region', default='us-east-1')
settings.update_from_env(prefix='CLOUD_')
```

## Main Script (`main.py`)

Features:
- Integrates `GlobalSettings` and `APIKeyManager`
- Manages cloud resources across AWS, Azure, and GCP
- Command-line interface for resource management and cost optimization

Usage:
```bash
python main.py --action list --resource instances
python main.py --cloud aws --action start --id i-1234567890abcdef0
python main.py --action optimize
```

## Security Notes

- Keep `api_keys.json`, `global_settings.json`, and encryption keys secure
- Don't commit sensitive information to version control
- Consider using environment variables or a secure secrets management solution for production

## Setup

1. Create necessary JSON files:
   - `api_keys.json` for storing encrypted API keys
   - `global_settings.json` for global configuration

2. Set up environment variables for sensitive data (optional)

3. Install required libraries:
   ```
   pip install cryptography
   ```

4. Import and use these classes in your main application as needed