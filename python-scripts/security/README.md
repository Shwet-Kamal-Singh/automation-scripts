# Security Management Scripts

This directory contains Python scripts for various security management tasks, including access control, audit log monitoring, encryption management, intrusion detection, security patch management, and vulnerability scanning.

## Files

- `access_control.py`: User and role-based access control management
- `audit_log_monitor.py`: Monitoring and alerting on suspicious audit log entries
- `encryption_management.py`: Key management and data encryption/decryption
- `intrusion_detection.py`: Basic Intrusion Detection System (IDS)
- `security_patch_management.py`: Management of security patches and updates
- `vulnerability_scan.py`: Basic vulnerability scanning tool
- `main.py`: Command-line interface for all security management functions

## Access Control (`access_control.py`)

Features:
- User management (add, remove, authenticate)
- Role management (add, remove)
- Permission checking
- User role changes

Usage:
````python
from access_control import AccessControl

ac = AccessControl()
ac.add_user("alice", "password123", "admin")
ac.authenticate("alice", "password123")
````


## Audit Log Monitor (`audit_log_monitor.py`)

Features:
- Continuous monitoring of audit log files
- Detection of suspicious activities based on keywords
- Alerting on potential security issues

Usage:
````python
from audit_log_monitor import AuditLogMonitor

monitor = AuditLogMonitor("/var/log/audit/audit.log")
monitor.monitor()
````


## Encryption Management (`encryption_management.py`)

Features:
- Key generation and management
- String and file encryption/decryption
- Password-based key derivation

Setup:
````bash
pip install cryptography
````


Usage:
````python
from encryption_management import EncryptionManager

em = EncryptionManager()
encrypted = em.encrypt_string("sensitive data")
decrypted = em.decrypt_string(encrypted)
````


## Intrusion Detection (`intrusion_detection.py`)

Features:
- Packet sniffing and analysis
- Detection of potential port scanning and DDoS attacks
- Basic SQL injection and XSS attempt detection

Setup:
````bash
pip install scapy
````


Usage:
````bash
sudo python intrusion_detection.py -i eth0
````


## Security Patch Management (`security_patch_management.py`)

Features:
- Checking for available system updates
- Installation of security patches
- Management of critical package updates

Usage:
````bash
sudo python security_patch_management.py
````


## Vulnerability Scan (`vulnerability_scan.py`)

Features:
- Port scanning
- SSL/TLS version checking
- HTTP header vulnerability checking
- FTP banner grabbing

Setup:
````bash
pip install python-nmap requests
````


Usage:
````python
from vulnerability_scan import VulnerabilityScanner

scanner = VulnerabilityScanner()
scanner.scan("192.168.1.100")
````


## Main Script (`main.py`)

Provides a command-line interface to all security management functions.

Usage:
````bash
python main.py --action access
python main.py --action audit
python main.py --action encrypt
python main.py --action ids --interface eth0
python main.py --action patch
python main.py --action scan --target 192.168.1.100
````


## Notes

- Many scripts require root privileges. Use with caution, especially in production environments.
- These are basic implementations and should be thoroughly tested and enhanced before use in production.
- Always ensure you have proper authorization before running security tools, especially those that interact with networks or systems.
- Consider using established enterprise-grade solutions for critical security functions in production environments.

