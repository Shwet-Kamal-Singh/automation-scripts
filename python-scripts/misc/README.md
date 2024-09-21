# Miscellaneous Utility Scripts

This directory contains various utility scripts for notifications, logging, service dependency mapping, and temporary file cleanup.

## Files

- `custom_notifications.py`: Manages different types of notifications
- `email_notifications.py`: Handles email notifications with advanced features
- `logging_setup.py`: Sets up logging for the project
- `service_dependency_mapping.py`: Maps and analyzes service dependencies
- `temp_file_cleanup.py`: Manages cleanup of temporary files
- `main.py`: Central script to run various utility tasks

## Custom Notifications (`custom_notifications.py`)

Features:
- Supports email, Slack, and SMS notifications
- Configurable using a dictionary
- Error handling and logging

Usage:
```python
from custom_notifications import NotificationManager

config = {
    'email': {'smtp_server': 'smtp.example.com', ...},
    'slack': {'webhook_url': 'https://hooks.slack.com/...'},
}
notifier = NotificationManager(config)
notifier.notify('email', 'subject', 'message', ['recipient@example.com'])
````


## Email Notifications (`email_notifications.py`)

Features:
- Sends plain text and HTML emails
- Supports multiple recipients, CC, and BCC
- Allows file attachments

Usage:
````python
from email_notifications import EmailNotifier

smtp_config = {
    'smtp_server': 'smtp.example.com',
    'smtp_port': 587,
    'username': 'your_username',
    'password': 'your_password'
}
emailer = EmailNotifier(smtp_config)
emailer.send_email('subject', 'body', ['recipient@example.com'])
````


## Service Dependency Mapping (`service_dependency_mapping.py`)

Features:
- Loads dependencies from YAML configuration
- Builds and visualizes dependency graphs
- Analyzes dependency structure

Setup:
1. Install required libraries:
   ```
   pip install networkx matplotlib pyyaml
   ```
2. Create a `services_config.yaml` file with your service dependencies

Usage:
````python
from service_dependency_mapping import ServiceDependencyMapper

mapper = ServiceDependencyMapper('services_config.yaml')
mapper.visualize_dependencies('output.png')
````


## Temporary File Cleanup (`temp_file_cleanup.py`)

Features:
- Cleans up temporary files in specified directories
- Filters by file extensions and age
- Can run as one-time cleanup or continuous process

Usage:
````python
from temp_file_cleanup import TempFileCleanup

cleaner = TempFileCleanup(['/tmp', '/var/tmp'], ['.tmp', '.log'], 7)
cleaner.run_cleanup(continuous=True, interval_hours=24)
````


## Main Script (`main.py`)

Features:
- Central entry point for running utility tasks
- Argument parsing for task selection
- Configuration loading from YAML file

Usage:
````bash
python main.py --config config.yaml --notifications --email --dependencies --cleanup
````


## Setup

1. Create a `config.yaml` file with configurations for all scripts
2. Install required libraries:
   ```
   pip install networkx matplotlib pyyaml
   ```
3. Run `main.py` with desired options to execute tasks

## Notes

- Update configuration files with actual credentials and paths
- Handle sensitive information securely, preferably using environment variables
- Test scripts thoroughly in a safe environment before using in production