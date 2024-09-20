# System Maintenance Automation Scripts

This directory contains batch scripts for automating various system maintenance tasks, providing a convenient way to keep your Windows system optimized and running smoothly.

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
system-maintenance/
├── README.md
├── cleanup-temp.bat
├── clear-event-logs.bat
├── defrag-disk.bat
├── disk-check.bat
├── main.bat
├── system-info-report.bat
└── windows-update.bat
```

## Scripts Overview

1. `cleanup-temp.bat`: Removes temporary files and folders to free up disk space.
2. `clear-event-logs.bat`: Clears Windows event logs to manage log file sizes.
3. `defrag-disk.bat`: Defragments specified disk drives to optimize performance.
4. `disk-check.bat`: Performs a disk check and attempts to fix file system errors.
5. `main.bat`: Provides a menu-driven interface to execute other system maintenance scripts.
6. `system-info-report.bat`: Generates a comprehensive system information report.
7. `windows-update.bat`: Checks for and installs Windows updates.

## Prerequisites

- Windows operating system
- Administrative privileges
- Basic understanding of Windows system maintenance concepts

## Usage

To use these system maintenance scripts, navigate to the `automation-scripts/batch-scripts/system-maintenance/` directory and run the desired script:

1. **Cleanup Temporary Files**:
   ```batch
   cleanup-temp.bat
   ```

2. **Clear Event Logs**:
   ```batch
   clear-event-logs.bat
   ```

3. **Defragment Disk**:
   ```batch
   defrag-disk.bat
   ```

4. **Disk Check**:
   ```batch
   disk-check.bat
   ```

5. **System Information Report**:
   ```batch
   system-info-report.bat
   ```

6. **Windows Update**:
   ```batch
   windows-update.bat
   ```

7. **Main Menu**:
   ```batch
   main.bat
   ```

## Automation Considerations

- `Administrative Rights`: Most system maintenance operations require elevated privileges. Always run these scripts with appropriate permissions.
- `System Impact`: Some maintenance tasks may temporarily impact system performance or require restarts.
- `Data Integrity`: Ensure important data is backed up before running maintenance scripts, especially disk-related operations.

## Troubleshooting

- `Permission Errors`: Ensure you're running the scripts with administrative privileges.
- `Disk Space Issues`: If scripts fail due to low disk space, run the cleanup script first.
- `Windows Update Errors`: For update issues, check your internet connection and Windows Update settings.

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

These scripts are provided as-is, without warranty. While they are designed to perform common system maintenance tasks, use caution when running them, as they can affect system performance and data. Always ensure you have backups before performing system maintenance.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh