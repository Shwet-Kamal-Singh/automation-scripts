import json
import os
import logging
from typing import Any, Dict

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class GlobalSettings:
    def __init__(self, config_file: str = 'global_settings.json'):
        self.config_file = config_file
        self.settings = self.load_settings()

    def load_settings(self) -> Dict[str, Any]:
        if os.path.exists(self.config_file):
            with open(self.config_file, 'r') as f:
                return json.load(f)
        return {}

    def save_settings(self) -> None:
        with open(self.config_file, 'w') as f:
            json.dump(self.settings, f, indent=2)
        logger.info(f"Settings saved to {self.config_file}")

    def get(self, key: str, default: Any = None) -> Any:
        return self.settings.get(key, default)

    def set(self, key: str, value: Any) -> None:
        self.settings[key] = value
        self.save_settings()
        logger.info(f"Setting '{key}' updated")

    def delete(self, key: str) -> None:
        if key in self.settings:
            del self.settings[key]
            self.save_settings()
            logger.info(f"Setting '{key}' deleted")
        else:
            logger.warning(f"Setting '{key}' not found")

    def list_all(self) -> Dict[str, Any]:
        return self.settings

    def update_from_env(self, prefix: str = 'CLOUD_') -> None:
        for key, value in os.environ.items():
            if key.startswith(prefix):
                setting_key = key[len(prefix):].lower()
                self.set(setting_key, value)
        logger.info(f"Settings updated from environment variables with prefix '{prefix}'")

# Example usage and default settings
if __name__ == "__main__":
    settings = GlobalSettings()

    # Set some default settings if they don't exist
    if not settings.get('default_region'):
        settings.set('default_region', 'us-west-2')
    if not settings.get('log_level'):
        settings.set('log_level', 'INFO')
    if not settings.get('max_instances'):
        settings.set('max_instances', 10)

    # Update settings from environment variables
    settings.update_from_env()

    # Print all settings
    print("Current Global Settings:")
    for key, value in settings.list_all().items():
        print(f"  {key}: {value}")

    # Example of getting a setting
    print(f"\nDefault Region: {settings.get('default_region')}")

    # Example of setting a new value
    settings.set('timeout', 300)

    # Example of deleting a setting
    settings.delete('timeout')

    # Try to get a non-existent setting with a default value
    print(f"API Version: {settings.get('api_version', 'v1.0')}")