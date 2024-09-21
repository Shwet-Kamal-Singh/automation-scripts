import psutil
import logging
from pathlib import Path

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def get_disk_usage(path):
    usage = psutil.disk_usage(path)
    return {
        'total': usage.total / (1024 * 1024 * 1024),  # GB
        'used': usage.used / (1024 * 1024 * 1024),    # GB
        'free': usage.free / (1024 * 1024 * 1024),    # GB
        'percent': usage.percent
    }

def monitor_disk_space(paths, threshold=80):
    for path in paths:
        if not Path(path).exists():
            logging.warning(f"Path does not exist: {path}")
            continue

        usage = get_disk_usage(path)
        logging.info(f"Disk usage for {path}:")
        logging.info(f"  Total: {usage['total']:.2f} GB")
        logging.info(f"  Used: {usage['used']:.2f} GB")
        logging.info(f"  Free: {usage['free']:.2f} GB")
        logging.info(f"  Usage: {usage['percent']}%")

        if usage['percent'] > threshold:
            logging.warning(f"Disk usage above {threshold}% for {path}")

def main():
    setup_logging()
    paths_to_monitor = ["/", "/home"]  # Add or modify paths as needed
    threshold = 80  # Adjust threshold as needed

    logging.info("Starting disk space monitoring...")
    monitor_disk_space(paths_to_monitor, threshold)
    logging.info("Disk space monitoring complete.")

if __name__ == "__main__":
    main()