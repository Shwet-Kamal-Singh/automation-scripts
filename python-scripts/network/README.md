# Network Management Scripts

This directory contains Python scripts for various network management tasks, including DNS management, firewall configuration, IP address management, load balancer configuration, network backup, and usage monitoring.

## Files

- `dns_management.py`: DNS lookup and zone transfer functions
- `firewall_management.py`: iptables-based firewall management
- `ip_address_management.py`: IP address configuration and management
- `load_balancer_config.py`: NGINX load balancer configuration
- `network_config_backup.py`: Network device configuration backup
- `network_usage_monitor.py`: Network usage monitoring and logging
- `main.py`: Command-line interface for all network management functions

## DNS Management (`dns_management.py`)

Features:
- DNS lookup for specified domain and record type
- Reverse DNS lookup
- DNS zone transfer (where permitted)

Setup:
```bash
pip install dnspython
```

Usage:
```python
from dns_management import lookup_dns, reverse_dns_lookup, transfer_zone

lookup_dns('example.com', 'A')
reverse_dns_lookup('8.8.8.8')
transfer_zone('example.com', 'ns1.example.com')
```

## Firewall Management (`firewall_management.py`)

Features:
- List, add, and delete iptables rules
- Block specific IP addresses
- Allow traffic on specific ports

Note: Requires root privileges

Usage:
```bash
sudo python firewall_management.py
```

## IP Address Management (`ip_address_management.py`)

Features:
- List, add, and remove IP addresses on network interfaces
- Check if an IP is within a specified network
- Get available IP addresses in a network

Note: Some functions require root privileges

Usage:
```python
from ip_address_management import list_ip_addresses, add_ip_address, remove_ip_address

list_ip_addresses()
add_ip_address('eth0', '192.168.1.10/24')
remove_ip_address('eth0', '192.168.1.10/24')
```

## Load Balancer Configuration (`load_balancer_config.py`)

Features:
- Read and write NGINX configuration
- Add upstream blocks for load balancing
- Add and remove server blocks

Note: Requires root privileges and assumes standard NGINX installation on Linux

Usage:
```python
from load_balancer_config import add_upstream, add_server, remove_server

add_upstream('backend', ['192.168.1.1', '192.168.1.2'])
add_server('example.com', '80', 'backend')
remove_server('example.com')
```

## Network Configuration Backup (`network_config_backup.py`)

Features:
- Backup configuration of network devices using SSH
- Schedule regular backups

Setup:
```bash
pip install paramiko schedule
```

Usage:
```python
from network_config_backup import backup_all_devices, schedule_backups

backup_all_devices(devices, backup_dir)
schedule_backups(devices, backup_dir, interval_hours=24)
```

## Network Usage Monitor (`network_usage_monitor.py`)

Features:
- Monitor network usage statistics
- Calculate network speeds
- Log data to CSV files

Setup:
```bash
pip install psutil
```

Usage:
```bash
python network_usage_monitor.py
```

## Main Script (`main.py`)

Provides a command-line interface to all network management functions.

Usage:
```bash
python main.py firewall list
python main.py ip add --interface eth0 --ip 192.168.1.10/24
python main.py loadbalancer add-upstream --name backend --servers 192.168.1.1,192.168.1.2
python main.py backup single --device 192.168.1.1
python main.py monitor --duration 3600
```

## Notes

- Many scripts require root privileges. Use with caution, especially in production environments.
- Always test in a safe environment before applying changes to critical systems.
- Adjust file paths and configurations as needed for your specific setup.
```

This README provides an overview of the scripts in the `network` directory, their features, setup instructions, and usage examples for users.
````
