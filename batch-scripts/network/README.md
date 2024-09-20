# Network Automation Scripts

This directory contains batch scripts for automating various network-related tasks, providing a convenient way to manage and troubleshoot network configurations from the command line.

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
network/
├── README.md
├── dns-flush.bat
├── ip-config.bat
├── main.bat
├── network-share-config.bat
├── ping-test.bat
├── traceroute-util.bat
└── wifi-profile-manager.bat
```


## Scripts Overview

1. `dns-flush.bat`: Flushes the DNS resolver cache.
2. `ip-config.bat`: Displays detailed IP configuration information.
3. `main.bat`: Provides a menu-driven interface to execute other network automation scripts.
4. `network-share-config.bat`: Configures network shares.
5. `ping-test.bat`: Performs ping tests to specified hosts.
6. `traceroute-util.bat`: Traces the route packets take to a specified destination.
7. `wifi-profile-manager.bat`: Manages Wi-Fi profiles on the system.

## Prerequisites

- Windows operating system
- Administrative privileges (for some network operations)
- Basic understanding of networking concepts

## Usage

To use these network automation scripts, navigate to the `automation-scripts/batch-scripts/network/` directory and run the desired script:

1. **DNS Flush**:
   ```batch
   dns-flush.bat
   ```

2. **IP Configuration**:
   ```batch
   ip-config.bat
   ```

3. **Network Share Configuration**:
   ```batch
   network-share-config.bat
   ```

4. **Ping Test**:
   ```batch
   ping-test.bat
   ```

5. **Traceroute Utility**:
   ```batch
   traceroute-util.bat
   ```

6. **Wi-Fi Profile Manager**:
   ```batch
   wifi-profile-manager.bat
   ```

7. **Main Menu**:
   ```batch
   main.bat
   ```

## Automation Considerations

- `Administrative Rights`: Some network operations require elevated privileges. Ensure you run these scripts with appropriate permissions.
- `Network Security`: Be cautious when automating network configurations to avoid unintended security risks.

## Troubleshooting

- `Permission Errors`: Ensure you're running the scripts with administrative privileges when required.
- `Network Connectivity Issues`: Verify your network connection is active before running these scripts.
- `Firewall Interference`: Some scripts may be affected by firewall settings. Adjust as necessary.

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

These scripts are provided as-is, without warranty. Use caution when running these scripts, especially those affecting network configurations, as they can significantly impact your system's connectivity.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh