# Miscellaneous Scripts

This directory contains various utility Bash scripts for system administration and maintenance tasks.

## Table of Contents

- [File Structure](#file-structure)
- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Considerations](#considerations)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contact](#contact)

## File Structure
```
misc/
├── README.md
├── api-interaction.sh
├── disk-usage-report.sh
├── environment-setup-teardown.sh
├── log-cleanup.sh
├── main.sh
├── ssh-key-management.sh
├── system-health-check.sh
└── temp-file-cleanup.sh
```

## Scripts Overview

1. `api-interaction.sh`: Handles interactions with various APIs.
2. `disk-usage-report.sh`: Generates reports on disk usage.
3. `environment-setup-teardown.sh`: Manages environment setup and teardown processes.
4. `log-cleanup.sh`: Performs log file cleanup and management.
5. `main.sh`: Provides a menu-driven interface to execute other miscellaneous scripts.
6. `ssh-key-management.sh`: Manages SSH keys for secure access.
7. `system-health-check.sh`: Performs system health checks and diagnostics.
8. `temp-file-cleanup.sh`: Cleans up temporary files to free up disk space.

## Prerequisites

- Bash shell environment
- Basic knowledge of system administration and scripting
- Appropriate permissions to run system-level tasks

## Usage

To use these miscellaneous scripts, navigate to the `automation-scripts/bash-scripts/misc/` directory and run the desired script:

1. **API Interaction**:
   ```bash
   ./api-interaction.sh
   ```

2. **Disk Usage Report**:
   ```bash
   ./disk-usage-report.sh
   ```

3. **Environment Setup/Teardown**:
   ```bash
   ./environment-setup-teardown.sh
   ```

4. **Log Cleanup**:
   ```bash
   ./log-cleanup.sh
   ```

5. **SSH Key Management**:
   ```bash
   ./ssh-key-management.sh
   ```

6. **System Health Check**:
   ```bash
   ./system-health-check.sh
   ```

7. **Temporary File Cleanup**:
   ```bash
   ./temp-file-cleanup.sh
   ```

8. **Main Menu**:
   ```bash
   ./main.sh
   ```

## Considerations

- `System Impact:` Be aware of the potential impact these scripts may have on system resources and performance.
- `Data Sensitivity:` Exercise caution when handling sensitive data, especially with API interactions and log management.
- `Backup:` Always maintain backups before performing cleanup or system-wide changes.

## Troubleshooting

- `Permission Errors:` Ensure the scripts have the necessary permissions to perform their tasks.
- `API Issues:` Verify API endpoints and authentication details for the `api-interaction.sh` script.
- `Disk Space:` If disk usage reports or cleanup scripts fail, check for available disk space.

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

These scripts are provided as-is, without warranty. Review and test thoroughly before using in any production environment.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh