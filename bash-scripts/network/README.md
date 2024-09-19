# Network Management Scripts

This directory contains Bash scripts for network management, monitoring, and configuration tasks.

## Table of Contents

- [File Structure](#file-structure)
- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Network Considerations](#network-considerations)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contact](#contact)

## File Structure
```
network/
├── README.md
├── firewall-config.sh
├── ip-monitor.sh
├── main.sh
├── network-config-backup.sh
├── network-monitor.sh
└── ufw-rule-management.sh
```


## Scripts Overview

1. `firewall-config.sh`: Configures and manages firewall settings.
2. `ip-monitor.sh`: Monitors IP addresses and network interfaces.
3. `main.sh`: Provides a menu-driven interface to execute other network management scripts.
4. `network-config-backup.sh`: Creates backups of network configurations.
5. `network-monitor.sh`: Monitors overall network performance and health.
6. `ufw-rule-management.sh`: Manages Uncomplicated Firewall (UFW) rules.

## Prerequisites

- Bash shell environment
- Root or sudo access for network configuration changes
- Basic knowledge of networking concepts and Linux network management

## Usage

To use these network management scripts, navigate to the `automation-scripts/bash-scripts/network/` directory and run the desired script:

1. **Firewall Configuration**:
   ```bash
   sudo ./firewall-config.sh
   ```

2. **IP Monitoring**:
   ```bash
   ./ip-monitor.sh
   ```

3. **Network Configuration Backup**:
   ```bash
   sudo ./network-config-backup.sh
   ```

4. **Network Monitoring**:
   ```bash
   ./network-monitor.sh
   ```

5. **UFW Rule Management**:
   ```bash
   sudo ./ufw-rule-management.sh
   ```

6. **Main Menu**:
   ```bash
   ./main.sh
   ```

## Network Considerations

- `Security:` Be cautious when modifying firewall rules or network configurations.
- `Backup:` Always create backups before making significant network changes.
- `Performance Impact:` Some monitoring scripts may impact network performance if run continuously.

## Troubleshooting

- `Permission Errors:` Ensure you have the necessary permissions (root or sudo) for scripts that modify network settings.
- `Firewall Issues:` If experiencing connectivity problems, check recent firewall configuration changes.
- `Network Interruptions:` Be prepared for potential network interruptions when running configuration scripts.

## Contributing

Contributions to enhance these scripts are welcome. Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test thoroughly.
4. Submit a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Shwet-Kamal-Singh/automation-scripts/blob/main/LICENSE) file for details.

![Original Creator](https://img.shields.io/badge/Original%20Creator-Shwet%20Kamal%20Singh-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## Disclaimer

These scripts are provided as-is, without warranty. Use caution when modifying network settings, as improper configuration can lead to network issues or security vulnerabilities.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh