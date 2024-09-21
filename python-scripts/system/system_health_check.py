import psutil
import platform
import logging
import datetime
import shutil

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def check_cpu():
    cpu_usage = psutil.cpu_percent(interval=1)
    logging.info(f"CPU Usage: {cpu_usage}%")
    return cpu_usage < 80

def check_memory():
    memory = psutil.virtual_memory()
    memory_usage = memory.percent
    logging.info(f"Memory Usage: {memory_usage}%")
    return memory_usage < 80

def check_disk():
    disk = psutil.disk_usage('/')
    disk_usage = disk.percent
    logging.info(f"Disk Usage: {disk_usage}%")
    return disk_usage < 80

def check_network():
    try:
        net_io = psutil.net_io_counters()
        logging.info(f"Network: Bytes Sent = {net_io.bytes_sent}, Bytes Recv = {net_io.bytes_recv}")
        return True
    except Exception as e:
        logging.error(f"Network check failed: {str(e)}")
        return False

def check_uptime():
    boot_time = psutil.boot_time()
    uptime = datetime.datetime.now().timestamp() - boot_time
    uptime_days = uptime / (24 * 3600)
    logging.info(f"System Uptime: {uptime_days:.2f} days")
    return uptime_days < 30  # Flag if uptime is more than 30 days

def check_processes():
    total_processes = len(psutil.pids())
    logging.info(f"Total Running Processes: {total_processes}")
    return total_processes < 300  # Arbitrary threshold, adjust as needed

def check_temperature():
    if hasattr(psutil, "sensors_temperatures"):
        temps = psutil.sensors_temperatures()
        if temps:
            for name, entries in temps.items():
                for entry in entries:
                    logging.info(f"Temperature {name}: {entry.current}°C")
                    if entry.current > 80:  # Arbitrary threshold, adjust as needed
                        return False
    return True

def system_health_check():
    checks = [
        ("CPU", check_cpu()),
        ("Memory", check_memory()),
        ("Disk", check_disk()),
        ("Network", check_network()),
        ("Uptime", check_uptime()),
        ("Processes", check_processes()),
        ("Temperature", check_temperature())
    ]

    all_passed = all(result for _, result in checks)
    status = "HEALTHY" if all_passed else "UNHEALTHY"
    
    logging.info(f"System Health Status: {status}")
    for check, result in checks:
        logging.info(f"{check} Check: {'PASSED' if result else 'FAILED'}")

    return all_passed

def main():
    setup_logging()
    logging.info("Starting System Health Check...")
    system_health = system_health_check()
    logging.info(f"System Health Check Complete. Overall Status: {'HEALTHY' if system_health else 'UNHEALTHY'}")

if __name__ == "__main__":
    main()