# System Management Scripts

This directory contains Python scripts for various system management tasks, including backup management, resource monitoring, update management, and system health checks.

## Files

- `backup_management.py`: Automated system backup creation and management
- `cpu_memory_monitor.py`: CPU and memory usage monitoring
- `disk_space_monitor.py`: Disk space usage monitoring
- `os_update_management.py`: Operating system update management
- `service_status_monitor.py`: Service status monitoring and management
- `software_inventory.py`: System software inventory management
- `system_health_check.py`: Comprehensive system health check
- `main.py`: Centralized script to run all system management tasks

## Backup Management (`backup_management.py`)

Features:
- Create timestamped backups
- Clean up old backups

Usage:
````python
from backup_management import create_backup, cleanup_old_backups

create_backup('/path/to/source', '/path/to/backups')
cleanup_old_backups('/path/to/backups', days=7)
````


## CPU and Memory Monitor (`cpu_memory_monitor.py`)

Features:
- Monitor CPU and memory usage
- Log usage information
- Issue warnings for high usage

Setup:
````bash
pip install psutil
````


Usage:
````python
from cpu_memory_monitor import monitor_resources

monitor_resources(duration=3600, interval=60)
````


## Disk Space Monitor (`disk_space_monitor.py`)

Features:
- Monitor disk space usage for multiple paths
- Log usage information
- Issue warnings for high usage

Usage:
````python
from disk_space_monitor import monitor_disk_space

paths = ["/", "/home"]
monitor_disk_space(paths, threshold=80)
````


## OS Update Management (`os_update_management.py`)

Features:
- Check for available updates (Windows and Linux)
- Install updates automatically

Usage:
````python
from os_update_management import manage_updates

manage_updates()
````


## Service Status Monitor (`service_status_monitor.py`)

Features:
- Monitor status of specified services
- Attempt to restart stopped services

Usage:
````python
from service_status_monitor import monitor_services

services = ["Service1", "Service2"]
monitor_services(services)
````


## Software Inventory (`software_inventory.py`)

Features:
- Generate software inventory for Windows and Linux systems
- Save inventory as JSON file

Usage:
````python
from software_inventory import get_software_inventory, save_inventory

inventory = get_software_inventory()
save_inventory(inventory)
````


## System Health Check (`system_health_check.py`)

Features:
- Check CPU, memory, and disk usage
- Verify network connectivity
- Check system uptime and running processes
- Monitor system temperature (if available)

Usage:
````python
from system_health_check import run_health_check

run_health_check()
````


## Main Script (`main.py`)

Centralizes all system management tasks with scheduled execution.

Usage:
````bash
python main.py
````


## Setup

1. Install required libraries:
   ```
   pip install psutil schedule
   ```
2. Ensure all scripts are in the same directory or in the Python path
3. Adjust paths, services, and schedules in `main.py` as needed
4. Run `main.py` with appropriate system permissions

## Notes

- Many scripts require administrative privileges. Use with caution in production environments.
- Adjust thresholds and schedules based on your specific system requirements.
- Consider implementing more robust error handling and alerting mechanisms for production use.
- Some features may be platform-specific (Windows/Linux). Ensure compatibility with your system.

