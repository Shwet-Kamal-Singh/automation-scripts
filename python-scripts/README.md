# Python Scripts

This repository contains a collection of Python scripts for various system administration and automation tasks. These scripts are organized into different categories for easy navigation and use.

## Table of Contents

- [Directory Structure](#directory-structure)
- [Categories](#categories)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Disclaimer](#disclaimer)
- [Contact](#contact)

## Directory Structure
```
python-scripts/
│
├── README.md
├── requirements.txt
│
├── cloud/
│   ├── aws_management.py
│   ├── azure_management.py
│   ├── cloud_cost_optimizer.py
│   ├── gcp_management.py
│   ├── main.py
│   └── README.md
│
├── config/
│   ├── api_keys.py
│   ├── global_settings.py
│   ├── main.py
│   └── README.md
│
├── database/
│   ├── db_mysql_backup.py
│   ├── db_performance_monitor.py
│   ├── db_postgresql_backup.py
│   ├── main.py
│   ├── query_optimizer.py
│   └── README.md
│
├── misc/
│   ├── custom_notifications.py
│   ├── email_notifications.py
│   ├── logging_setup.py
│   ├── main.py
│   ├── README.md
│   ├── service_dependency_mapping.py
│   └── temp_file_cleanup.py
│
├── network/
│   ├── dns_management.py
│   ├── firewall_management.py
│   ├── ip_address_management.py
│   ├── load_balancer_config.py
│   ├── main.py
│   ├── network_config_backup.py
│   ├── network_usage_monitor.py
│   └── README.md
│
├── security/
│   ├── access_control.py
│   ├── audit_log_monitor.py
│   ├── encryption_management.py
│   ├── intrusion_detection.py
│   ├── main.py
│   ├── README.md
│   ├── security_patch_management.py
│   └── vulnerability_scan.py
│
├── system/
│   ├── backup_management.py
│   ├── cpu_memory_monitor.py
│   ├── disk_space_monitor.py
│   ├── main.py
│   ├── os_update_management.py
│   ├── README.md
│   ├── service_status_monitor.py
│   ├── software_inventory.py
│   └── system_health_check.py
│
└── users/
    ├── group_creation.py
    ├── group_management.py
    ├── main.py
    ├── README.md
    ├── single_sign_on.py
    ├── ssh_key_management.py
    ├── user_activity_monitor.py
    └── user_creation.py
```


## Categories

1. **[Cloud](./cloud/README.md)**: Scripts for managing cloud resources across AWS, Azure, and GCP.
2. **[Config](./config/README.md)**: Configuration management scripts for API keys and global settings.
3. **[Database](./database/README.md)**: Database management scripts for MySQL and PostgreSQL.
4. **[Misc](./misc/README.md)**: Miscellaneous utility scripts for notifications, logging, and file cleanup.
5. **[Network](./network/README.md)**: Network configuration and monitoring scripts.
6. **[Security](./security/README.md)**: Security-related scripts for system protection and auditing.
7. **[System](./system/README.md)**: System monitoring and maintenance scripts.
8. **[Users](./users/README.md)**: User and group management scripts.

Each category has its own README.md file with detailed information about the scripts it contains.

## Prerequisites

- Python 3.x
- pip (Python package manager)
- Various Python libraries (listed in requirements.txt)
- Appropriate permissions for system operations
- Specific cloud provider accounts and credentials for cloud management scripts

## Usage

1. Clone this repository:
   ```
   git clone https://github.com/Shwet-Kamal-Singh/automation-scripts.git
   ```

2. Navigate to the python-scripts directory:
   ```
   cd automation-scripts/python-scripts
   ```

3. Install required Python packages:
   ```
   pip install -r requirements.txt
   ```

4. Choose the category of scripts you need and navigate to that directory.

5. Read the README.md file in the category directory for specific usage instructions.

6. Run the script using Python:
   ```
   python script_name.py
   ```

## Contributing

Contributions to this project are welcome. Please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test thoroughly.
4. Submit a pull request with a clear description of your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Shwet-Kamal-Singh/automation-scripts/blob/main/LICENSE) file for details.

![Original Creator](https://img.shields.io/badge/Original%20Creator-Shwet%20Kamal%20Singh-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## Disclaimer

These scripts are provided as-is, without warranty. Use caution when running these scripts, especially those requiring elevated privileges, as they can significantly impact your system.

## Contact

For any inquiries or permissions, please contact:
- Email: shwetkamalsingh55@gmail.com
- LinkedIn: https://www.linkedin.com/in/shwet-kamal-singh/
- GitHub: https://github.com/Shwet-Kamal-Singh