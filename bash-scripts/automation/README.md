# Automation Scripts

This directory contains Bash scripts for automating various tasks, providing a convenient way to automate routine tasks from the command line.

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
automation/
├── README.md
├── cron-automation.sh
├── deploy-automation.sh
├── first-setup.sh
├── main.sh
├── nginx-ssl.sh
├── server-hardening.sh
└── server-provision.sh
```


## Scripts Overview

1. `cron-automation.sh`: Sets up cron jobs to automate tasks.
2. `deploy-automation.sh`: Automates the deployment of software or updates.
3. `first-setup.sh`: Handles initial setup tasks for a new server or environment.
4. `main.sh`: Provides a menu-driven interface to execute other automation scripts.
5. `nginx-ssl.sh`: Automates the installation of SSL certificates using Certbot.
6. `server-hardening.sh`: Applies security measures to harden the server.
7. `server-provision.sh`: Sets up a server with necessary software and configurations.

## Prerequisites

- Bash shell environment
- Basic knowledge of automation and scripting

## Usage

To use these automation scripts, navigate to the `automation-scripts/bash-scripts/automation/` directory and run the desired script:

1. **Cron Automation**:
   ```bash
   ./cron-automation.sh
   ```

2. **Deployment Automation**:
   ```bash
   ./deploy-automation.sh
   ```

3. **First Setup**:
   ```bash
   ./first-setup.sh
   ```

4. **Server Hardening**:
   ```bash
   ./server-hardening.sh
   ```

5. **Server Provision**:
   ```bash
   ./server-provision.sh
   ```

6. **Nginx SSL**:
   ```bash
   ./nginx-ssl.sh
   ```

7. **Main Menu**:
   ```bash
   ./main.sh
   ```

## Automation Considerations

- `Permissions:` Ensure that the user executing these scripts has the necessary permissions to automate tasks.
- `Security:` Be cautious when automating tasks that could affect system stability or security.

## Troubleshooting

- `Permission Denied Errors:` Make sure the scripts are executable (`chmod +x *.sh`) and that your user has the necessary permissions.
- `Script Not Found:` Check that the scripts are in the correct directory and properly named.
- `Execution Errors:` Verify that all configurations and paths specified in the scripts are correct and compatible with your system's settings.

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

These scripts are provided as-is, without warranty. Review before running, especially those requiring sudo privileges.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh