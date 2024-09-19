# System Management Scripts

This directory contains Bash scripts for various system management tasks, including monitoring, log rotation, and system updates.

## Table of Contents

- [File Structure](#file-structure)
- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [System Considerations](#system-considerations)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contact](#contact)

## File Structure
```
system/
├── README.md
├── cpu-memory-monitor.sh
├── disk-space-monitor.sh
├── log-rotation.sh
├── main.sh
├── service-status-monitor.sh
└── system-update.sh
```


## Scripts Overview

1. `cpu-memory-monitor.sh`: Monitors CPU and memory usage.
2. `disk-space-monitor.sh`: Monitors available disk space.
3. `log-rotation.sh`: Manages log rotation to prevent log files from consuming too much disk space.
4. `main.sh`: Provides a menu-driven interface to execute other system management scripts.
5. `service-status-monitor.sh`: Monitors the status of system services.
6. `system-update.sh`: Performs system updates.

## Prerequisites

- Bash shell environment
- Root or sudo access for system operations
- Basic understanding of Linux system administration

## Usage

To use these system management scripts, navigate to the `automation-scripts/bash-scripts/system/` directory and run the desired script:

1. **CPU and Memory Monitoring**:
   ```bash
   ./cpu-memory-monitor.sh
   ```

2. **Disk Space Monitoring**:
   ```bash
   ./disk-space-monitor.sh
   ```

3. **Log Rotation**:
   ```bash
   sudo ./log-rotation.sh
   ```

4. **Service Status Monitoring**:
   ```bash
   ./service-status-monitor.sh
   ```

5. **System Update**:
   ```bash
   sudo ./system-update.sh
   ```

6. **Main Menu**:
   ```bash
   ./main.sh
   ```

## System Considerations

- `Resource Usage:` Monitoring scripts may consume additional system resources.
- `Disk Space:` Ensure sufficient disk space before running updates or log rotations.
- `Service Interruptions:` System updates may require service restarts or system reboots.

## Troubleshooting

- `Permission Errors:` Ensure you have the necessary permissions (root or sudo) for system operations.
- `Monitoring Accuracy:` Verify that monitoring scripts are reporting accurate information.
- `Update Failures:` If system updates fail, check network connectivity and package repository status.

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

These scripts are provided as-is, without warranty. Use caution when performing system operations, especially updates and log rotations, as they can impact system stability and performance.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh
