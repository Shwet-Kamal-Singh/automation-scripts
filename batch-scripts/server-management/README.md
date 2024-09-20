# Server Management Automation Scripts

This directory contains batch scripts for automating various server management tasks, providing a convenient way to monitor, configure, and maintain servers from the command line.

## Table of Contents

- [File Structure](#file-structure)
- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Automation Considerations](#automation-considerations)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contact](#contact)

## File Structure
```
server-management/
├── README.md
├── log-rotator.bat
├── main.bat
├── remote-desktop-disabler.bat
├── remote-desktop-enabler.bat
├── server-monitor.bat
├── service-controller.bat
├── ssh-key-manager.bat
└── web-server-config.bat
```

## Scripts Overview

1. `log-rotator.bat`: Automates log file rotation to manage disk space.
2. `main.bat`: Provides a menu-driven interface to execute other server management scripts.
3. `remote-desktop-disabler.bat`: Disables Remote Desktop Protocol (RDP) access.
4. `remote-desktop-enabler.bat`: Enables Remote Desktop Protocol (RDP) access.
5. `server-monitor.bat`: Monitors server resources and performance.
6. `service-controller.bat`: Manages Windows services (start, stop, restart).
7. `ssh-key-manager.bat`: Manages SSH keys for secure remote access.
8. `web-server-config.bat`: Configures web server settings (e.g., IIS, Apache).

## Prerequisites

- Windows Server operating system
- Administrative privileges
- Basic understanding of server management concepts and Windows Server features

## Usage

To use these server management scripts, navigate to the `automation-scripts/batch-scripts/server-management/` directory and run the desired script:

1. **Log Rotator**:
   ```batch
   log-rotator.bat
   ```

2. **Remote Desktop Disabler**:
   ```batch
   remote-desktop-disabler.bat
   ```

3. **Remote Desktop Enabler**:
   ```batch
   remote-desktop-enabler.bat
   ```

4. **Server Monitor**:
   ```batch
   server-monitor.bat
   ```

5. **Service Controller**:
   ```batch
   service-controller.bat
   ```

6. **SSH Key Manager**:
   ```batch
   ssh-key-manager.bat
   ```

7. **Web Server Config**:
   ```batch
   web-server-config.bat
   ```

8. **Main Menu**:
   ```batch
   main.bat
   ```

## Automation Considerations

- `Administrative Rights`: Server management operations require elevated privileges. Always run these scripts with appropriate permissions.
- `Service Interruptions`: Some scripts may affect running services or user connections. Plan maintenance windows accordingly.
- `Configuration Backups`: Always backup critical configurations before making automated changes.

## Troubleshooting

- `Permission Errors`: Ensure you're running the scripts with administrative privileges.
- `Service Dependencies`: Be aware of service dependencies when starting or stopping services.
- `Network Issues`: For remote management, ensure proper network connectivity and firewall configurations.

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

These scripts are provided as-is, without warranty. Use caution when running server management scripts, as they can significantly impact server operations and security. Always test in a non-production environment first.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh