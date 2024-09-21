import platform
import subprocess
import logging
from datetime import datetime

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def run_command(command):
    try:
        result = subprocess.run(command, check=True, text=True, capture_output=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        logging.error(f"Command failed: {e}")
        return None

def check_updates_windows():
    command = ["powershell", "Get-WUList"]
    output = run_command(command)
    if output:
        updates = output.count('\n') - 1  # Subtract header line
        logging.info(f"Windows: {updates} updates available")
    else:
        logging.error("Failed to check for Windows updates")

def install_updates_windows():
    command = ["powershell", "Install-WindowsUpdate", "-AcceptAll", "-AutoReboot"]
    output = run_command(command)
    if output:
        logging.info("Windows updates installed successfully")
    else:
        logging.error("Failed to install Windows updates")

def check_updates_linux():
    if platform.linux_distribution()[0].lower() in ['ubuntu', 'debian']:
        command = ["apt", "list", "--upgradable"]
    elif platform.linux_distribution()[0].lower() in ['centos', 'rhel', 'fedora']:
        command = ["yum", "check-update"]
    else:
        logging.error("Unsupported Linux distribution")
        return

    output = run_command(command)
    if output:
        updates = output.count('\n') - 1  # Subtract header line
        logging.info(f"Linux: {updates} updates available")
    else:
        logging.error("Failed to check for Linux updates")

def install_updates_linux():
    if platform.linux_distribution()[0].lower() in ['ubuntu', 'debian']:
        command = ["sudo", "apt", "upgrade", "-y"]
    elif platform.linux_distribution()[0].lower() in ['centos', 'rhel', 'fedora']:
        command = ["sudo", "yum", "update", "-y"]
    else:
        logging.error("Unsupported Linux distribution")
        return

    output = run_command(command)
    if output:
        logging.info("Linux updates installed successfully")
    else:
        logging.error("Failed to install Linux updates")

def manage_updates():
    os_type = platform.system()
    if os_type == "Windows":
        check_updates_windows()
        install_updates_windows()
    elif os_type == "Linux":
        check_updates_linux()
        install_updates_linux()
    else:
        logging.error(f"Unsupported operating system: {os_type}")

def main():
    setup_logging()
    logging.info("Starting OS update management...")
    manage_updates()
    logging.info("OS update management complete.")

if __name__ == "__main__":
    main()