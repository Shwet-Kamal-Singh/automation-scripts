# Security Automation Scripts

This directory contains batch scripts for automating various security-related tasks, providing a convenient way to enhance and manage system security from the command line.

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
security/
├── README.md
├── antivirus-scan.bat
├── decrypt-files.bat
├── encrypt-files.bat
├── firewall-config.bat
├── main.bat
└── security-audit.bat
```

## Scripts Overview

1. `antivirus-scan.bat`: Initiates a system-wide antivirus scan.
2. `decrypt-files.bat`: Decrypts specified files or directories.
3. `encrypt-files.bat`: Encrypts specified files or directories.
4. `firewall-config.bat`: Configures Windows Firewall settings.
5. `main.bat`: Provides a menu-driven interface to execute other security automation scripts.
6. `security-audit.bat`: Performs a basic security audit of the system.

## Prerequisites

- Windows operating system
- Administrative privileges
- Basic understanding of security concepts and Windows security features

## Usage

To use these security automation scripts, navigate to the `automation-scripts/batch-scripts/security/` directory and run the desired script:

1. **Antivirus Scan**:
   ```batch
   antivirus-scan.bat
   ```

2. **Decrypt Files**:
   ```batch
   decrypt-files.bat
   ```

3. **Encrypt Files**:
   ```batch
   encrypt-files.bat
   ```

4. **Firewall Configuration**:
   ```batch
   firewall-config.bat
   ```

5. **Security Audit**:
   ```batch
   security-audit.bat
   ```

6. **Main Menu**:
   ```batch
   main.bat
   ```

## Automation Considerations

- `Administrative Rights`: Most security operations require elevated privileges. Always run these scripts with appropriate permissions.
- `Data Sensitivity`: Be extremely cautious when automating tasks involving sensitive data, especially with encryption and decryption scripts.
- `System Impact`: Some security operations may temporarily impact system performance or require restarts.

## Troubleshooting

- `Permission Errors`: Ensure you're running the scripts with administrative privileges.
- `Antivirus Interference`: Some antivirus software may interfere with security scripts. Temporarily disable if necessary, but exercise caution.
- `Encryption/Decryption Issues`: Verify that you have the correct keys or passwords for encryption/decryption operations.

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

These scripts are provided as-is, without warranty. Use extreme caution when running security-related scripts, as they can significantly impact your system's security posture and data integrity. Always review and understand the scripts before execution.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh