import os
import subprocess
import json
import logging
from datetime import datetime

class SecurityPatchManager:
    def __init__(self, config_file='patch_config.json'):
        self.config_file = config_file
        self.config = self.load_config()
        self.setup_logging()

    def setup_logging(self):
        logging.basicConfig(
            filename='patch_management.log',
            level=logging.INFO,
            format='%(asctime)s - %(levelname)s - %(message)s'
        )

    def load_config(self):
        if os.path.exists(self.config_file):
            with open(self.config_file, 'r') as f:
                return json.load(f)
        return {
            "last_update": None,
            "update_frequency_days": 7,
            "critical_packages": ["openssl", "bash", "kernel"]
        }

    def save_config(self):
        with open(self.config_file, 'w') as f:
            json.dump(self.config, f, indent=2)

    def check_for_updates(self):
        logging.info("Checking for updates...")
        try:
            subprocess.run(["sudo", "apt", "update"], check=True)
            return True
        except subprocess.CalledProcessError as e:
            logging.error(f"Error checking for updates: {e}")
            return False

    def list_available_updates(self):
        try:
            result = subprocess.run(["apt", "list", "--upgradable"], capture_output=True, text=True, check=True)
            return result.stdout.split('\n')[1:-1]  # Exclude the first line (header) and last line (empty)
        except subprocess.CalledProcessError as e:
            logging.error(f"Error listing available updates: {e}")
            return []

    def install_updates(self, packages=None):
        cmd = ["sudo", "apt", "upgrade", "-y"]
        if packages:
            cmd.extend(packages)
        
        try:
            subprocess.run(cmd, check=True)
            logging.info(f"Successfully installed updates for: {packages if packages else 'all packages'}")
            return True
        except subprocess.CalledProcessError as e:
            logging.error(f"Error installing updates: {e}")
            return False

    def check_critical_packages(self):
        critical_updates = []
        all_updates = self.list_available_updates()
        for update in all_updates:
            package_name = update.split('/')[0]
            if package_name in self.config['critical_packages']:
                critical_updates.append(package_name)
        return critical_updates

    def run_patch_cycle(self):
        logging.info("Starting patch cycle")
        if self.check_for_updates():
            critical_updates = self.check_critical_packages()
            if critical_updates:
                logging.warning(f"Critical updates available for: {', '.join(critical_updates)}")
                self.install_updates(critical_updates)
            else:
                all_updates = self.list_available_updates()
                if all_updates:
                    logging.info(f"Non-critical updates available: {len(all_updates)}")
                    self.install_updates()
                else:
                    logging.info("No updates available")
        
        self.config['last_update'] = datetime.now().isoformat()
        self.save_config()
        logging.info("Patch cycle completed")

def main():
    patch_manager = SecurityPatchManager()
    patch_manager.run_patch_cycle()

if __name__ == "__main__":
    main()