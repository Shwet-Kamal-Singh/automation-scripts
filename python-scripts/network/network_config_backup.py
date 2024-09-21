import paramiko
import os
from datetime import datetime
import schedule
import time

def backup_device_config(device, username, password, backup_dir):
    try:
        # Establish SSH connection
        ssh = paramiko.SSHClient()
        ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
        ssh.connect(device, username=username, password=password)

        # Execute command to get configuration
        stdin, stdout, stderr = ssh.exec_command('show running-config')
        config = stdout.read().decode('utf-8')

        # Create backup filename with timestamp
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"{device}_{timestamp}.cfg"
        filepath = os.path.join(backup_dir, filename)

        # Write configuration to file
        with open(filepath, 'w') as f:
            f.write(config)

        print(f"Backup successful: {filepath}")

        # Close SSH connection
        ssh.close()

    except Exception as e:
        print(f"Error backing up {device}: {str(e)}")

def backup_all_devices(devices, username, password, backup_dir):
    for device in devices:
        backup_device_config(device, username, password, backup_dir)

def schedule_backups(devices, username, password, backup_dir, interval_hours):
    schedule.every(interval_hours).hours.do(backup_all_devices, devices, username, password, backup_dir)

    while True:
        schedule.run_pending()
        time.sleep(60)

if __name__ == "__main__":
    # Configuration
    devices = ['192.168.1.1', '192.168.1.2', '192.168.1.3']  # List of device IP addresses
    username = 'admin'
    password = 'password'
    backup_dir = '/path/to/backup/directory'
    interval_hours = 24  # Backup every 24 hours

    # Create backup directory if it doesn't exist
    os.makedirs(backup_dir, exist_ok=True)

    # Run initial backup
    backup_all_devices(devices, username, password, backup_dir)

    # Schedule regular backups
    schedule_backups(devices, username, password, backup_dir, interval_hours)