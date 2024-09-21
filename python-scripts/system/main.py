import logging
import schedule
import time
from backup_management import create_backup, cleanup_old_backups
from cpu_memory_monitor import monitor_resources
from disk_space_monitor import monitor_disk_space
from service_status_monitor import monitor_services
from os_update_management import manage_updates
from software_inventory import get_software_inventory, save_inventory
from system_health_check import system_health_check

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def run_backup():
    logging.info("Running backup...")
    create_backup("/path/to/source", "/path/to/backups")
    cleanup_old_backups("/path/to/backups")

def run_resource_monitor():
    logging.info("Running resource monitor...")
    monitor_resources(interval=300, duration=3600)  # Monitor for 1 hour, check every 5 minutes

def run_disk_monitor():
    logging.info("Running disk space monitor...")
    paths_to_monitor = ["/", "/home"]
    monitor_disk_space(paths_to_monitor)

def run_service_monitor():
    logging.info("Running service status monitor...")
    services_to_monitor = ["wuauserv", "BITS", "Spooler"]  # Example services
    monitor_services(services_to_monitor)

def run_update_management():
    logging.info("Running OS update management...")
    manage_updates()

def run_software_inventory():
    logging.info("Running software inventory...")
    inventory = get_software_inventory()
    if inventory:
        save_inventory(inventory)

def run_health_check():
    logging.info("Running system health check...")
    system_health_check()

def main():
    setup_logging()
    logging.info("Starting system management and monitoring...")

    # Schedule tasks
    schedule.every().day.at("01:00").do(run_backup)
    schedule.every(1).hours.do(run_resource_monitor)
    schedule.every(2).hours.do(run_disk_monitor)
    schedule.every(30).minutes.do(run_service_monitor)
    schedule.every().week.do(run_update_management)
    schedule.every().day.do(run_software_inventory)
    schedule.every(3).hours.do(run_health_check)

    # Run all tasks once at startup
    run_backup()
    run_resource_monitor()
    run_disk_monitor()
    run_service_monitor()
    run_update_management()
    run_software_inventory()
    run_health_check()

    # Keep the script running and execute scheduled tasks
    while True:
        schedule.run_pending()
        time.sleep(60)

if __name__ == "__main__":
    main()