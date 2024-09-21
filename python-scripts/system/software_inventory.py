import platform
import subprocess
import logging
import json
from datetime import datetime

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def get_windows_software():
    try:
        cmd = 'wmic product get name,version,vendor'
        output = subprocess.check_output(cmd, shell=True).decode('utf-8').strip()
        lines = output.split('\n')[1:]
        software = [line.split(None, 2) for line in lines if line.strip()]
        return [{'name': s[0], 'version': s[1], 'vendor': s[2] if len(s) > 2 else 'Unknown'} for s in software]
    except subprocess.CalledProcessError as e:
        logging.error(f"Error getting Windows software inventory: {str(e)}")
        return []

def get_linux_software():
    try:
        cmd = 'dpkg-query -W -f=\'${Package}\t${Version}\t${Maintainer}\n\''
        output = subprocess.check_output(cmd, shell=True).decode('utf-8').strip()
        lines = output.split('\n')
        return [{'name': line.split('\t')[0], 'version': line.split('\t')[1], 'vendor': line.split('\t')[2]} for line in lines]
    except subprocess.CalledProcessError:
        try:
            cmd = 'rpm -qa --queryformat "%{NAME}\t%{VERSION}\t%{VENDOR}\n"'
            output = subprocess.check_output(cmd, shell=True).decode('utf-8').strip()
            lines = output.split('\n')
            return [{'name': line.split('\t')[0], 'version': line.split('\t')[1], 'vendor': line.split('\t')[2]} for line in lines]
        except subprocess.CalledProcessError as e:
            logging.error(f"Error getting Linux software inventory: {str(e)}")
            return []

def get_software_inventory():
    os_type = platform.system()
    if os_type == "Windows":
        return get_windows_software()
    elif os_type == "Linux":
        return get_linux_software()
    else:
        logging.error(f"Unsupported operating system: {os_type}")
        return []

def save_inventory(inventory):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"software_inventory_{timestamp}.json"
    with open(filename, 'w') as f:
        json.dump(inventory, f, indent=2)
    logging.info(f"Inventory saved to {filename}")

def main():
    setup_logging()
    logging.info("Starting software inventory...")
    inventory = get_software_inventory()
    if inventory:
        logging.info(f"Found {len(inventory)} software items")
        save_inventory(inventory)
    else:
        logging.warning("No software inventory found")
    logging.info("Software inventory complete.")

if __name__ == "__main__":
    main()