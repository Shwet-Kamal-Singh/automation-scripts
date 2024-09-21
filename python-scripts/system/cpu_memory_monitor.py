import psutil
import time
import logging
from datetime import datetime

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def get_cpu_usage():
    return psutil.cpu_percent(interval=1)

def get_memory_usage():
    memory = psutil.virtual_memory()
    return memory.percent, memory.available / (1024 * 1024)  # Available memory in MB

def monitor_resources(interval=60, duration=3600):
    end_time = time.time() + duration
    while time.time() < end_time:
        cpu_usage = get_cpu_usage()
        mem_usage, mem_available = get_memory_usage()
        
        logging.info(f"CPU Usage: {cpu_usage}% | Memory Usage: {mem_usage}% | Available Memory: {mem_available:.2f} MB")
        
        if cpu_usage > 80 or mem_usage > 80:
            logging.warning("High resource usage detected!")
        
        time.sleep(interval)

def main():
    setup_logging()
    logging.info("Starting CPU and Memory monitoring...")
    monitor_resources()
    logging.info("Monitoring complete.")

if __name__ == "__main__":
    main()