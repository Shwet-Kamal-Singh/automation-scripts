import psutil
import logging
import time
from subprocess import call, CalledProcessError

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def check_service_status(service_name):
    try:
        service = psutil.win_service_get(service_name)
        return service.status()
    except psutil.NoSuchProcess:
        return "Not Found"

def restart_service(service_name):
    try:
        call(["sc", "stop", service_name])
        time.sleep(5)  # Wait for the service to stop
        call(["sc", "start", service_name])
        logging.info(f"Service {service_name} restarted successfully.")
    except CalledProcessError as e:
        logging.error(f"Failed to restart service {service_name}: {str(e)}")

def monitor_services(services, interval=300):
    while True:
        for service_name in services:
            status = check_service_status(service_name)
            logging.info(f"Service {service_name} status: {status}")
            
            if status != "running":
                logging.warning(f"Service {service_name} is not running. Attempting to restart...")
                restart_service(service_name)
        
        time.sleep(interval)

def main():
    setup_logging()
    services_to_monitor = [
        "wuauserv",  # Windows Update
        "BITS",      # Background Intelligent Transfer Service
        "Spooler"    # Print Spooler
    ]
    
    logging.info("Starting service status monitoring...")
    monitor_services(services_to_monitor)

if __name__ == "__main__":
    main()