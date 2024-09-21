import os
import subprocess
from datetime import datetime
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def mysql_backup(host, user, password, database, backup_dir):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"{database}_{timestamp}.sql"
    backup_path = os.path.join(backup_dir, filename)

    command = [
        "mysqldump",
        f"--host={host}",
        f"--user={user}",
        f"--password={password}",
        database
    ]

    try:
        with open(backup_path, 'w') as output_file:
            subprocess.run(command, stdout=output_file, check=True)
        logging.info(f"Backup created successfully: {backup_path}")
    except subprocess.CalledProcessError as e:
        logging.error(f"Backup failed: {e}")
    except IOError as e:
        logging.error(f"Error writing backup file: {e}")

if __name__ == "__main__":
    # Configuration
    DB_HOST = "localhost"
    DB_USER = "your_username"
    DB_PASSWORD = "your_password"
    DB_NAME = "your_database"
    BACKUP_DIR = "/path/to/backup/directory"

    mysql_backup(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, BACKUP_DIR)