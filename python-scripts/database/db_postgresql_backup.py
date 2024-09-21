import os
import subprocess
from datetime import datetime
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def postgres_backup(host, port, user, database, backup_dir):
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"{database}_{timestamp}.sql"
    backup_path = os.path.join(backup_dir, filename)

    command = [
        "pg_dump",
        f"--host={host}",
        f"--port={port}",
        f"--username={user}",
        f"--dbname={database}",
        f"--file={backup_path}",
        "--format=plain",
        "--no-owner",
        "--no-acl"
    ]

    try:
        subprocess.run(command, check=True, env=dict(os.environ, PGPASSWORD=os.environ.get('PGPASSWORD')))
        logging.info(f"Backup created successfully: {backup_path}")
    except subprocess.CalledProcessError as e:
        logging.error(f"Backup failed: {e}")
    except Exception as e:
        logging.error(f"An error occurred: {e}")

if __name__ == "__main__":
    # Configuration
    DB_HOST = "localhost"
    DB_PORT = "5432"
    DB_USER = "your_username"
    DB_NAME = "your_database"
    BACKUP_DIR = "/path/to/backup/directory"

    # Set PGPASSWORD environment variable
    os.environ['PGPASSWORD'] = 'your_password'

    postgres_backup(DB_HOST, DB_PORT, DB_USER, DB_NAME, BACKUP_DIR)