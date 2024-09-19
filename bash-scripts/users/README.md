# User Management Scripts

This directory contains Bash scripts for managing user accounts, groups, and monitoring user activity on the system.

## Table of Contents

- [File Structure](#file-structure)
- [Scripts Overview](#scripts-overview)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [User Management Considerations](#user-management-considerations)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contact](#contact)

## File Structure
```
users/
├── README.md
├── bulk-user-create.sh
├── group-management.sh
├── main.sh
├── single-user-create.sh
└── user-activity-monitor.sh
```

## Scripts Overview

1. `bulk-user-create.sh`: Creates multiple user accounts at once.
2. `group-management.sh`: Manages user groups (create, delete, modify).
3. `main.sh`: Provides a menu-driven interface to execute other user management scripts.
4. `single-user-create.sh`: Creates a single user account.
5. `user-activity-monitor.sh`: Monitors and reports on user activity.

## Prerequisites

- Bash shell environment
- Root or sudo access for user management operations
- Basic understanding of Linux user and group management concepts

## Usage

To use these user management scripts, navigate to the `automation-scripts/bash-scripts/users/` directory and run the desired script:

1. **Bulk User Creation**:
   ```bash
   sudo ./bulk-user-create.sh
   ```

2. **Group Management**:
   ```bash
   sudo ./group-management.sh
   ```

3. **Single User Creation**:
   ```bash
   sudo ./single-user-create.sh
   ```

4. **User Activity Monitoring**:
   ```bash
   sudo ./user-activity-monitor.sh
   ```

5. **Main Menu**:
   ```bash
   ./main.sh
   ```

## User Management Considerations

- `Security:` Ensure strong password policies when creating new users.
- `Permissions:` Be cautious when assigning group memberships and permissions.
- `Privacy:` Respect user privacy when monitoring activity.

## Troubleshooting

- `Permission Errors:` Ensure you have the necessary permissions (root or sudo) for user management operations.
- `Duplicate Users/Groups:` Check for existing users or groups before creation to avoid conflicts.
- `Monitoring Issues:` Verify that user activity monitoring doesn't interfere with system performance.

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

These scripts are provided as-is, without warranty. Use caution when managing user accounts and monitoring activity, as improper use may impact system security and user privacy.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh