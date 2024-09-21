import os
import shutil
import datetime
import logging
from pathlib import Path

def setup_logging():
    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def create_backup(source_dir, backup_dir):
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_name = f"backup_{timestamp}"
    backup_path = Path(backup_dir) / backup_name

    try:
        shutil.copytree(source_dir, backup_path)
        logging.info(f"Backup created successfully: {backup_path}")
    except Exception as e:
        logging.error(f"Backup failed: {str(e)}")

def cleanup_old_backups(backup_dir, max_backups=5):
    backups = sorted(Path(backup_dir).glob("backup_*"))
    while len(backups) > max_backups:
        oldest_backup = backups.pop(0)
        shutil.rmtree(oldest_backup)
        logging.info(f"Removed old backup: {oldest_backup}")

def main():
    setup_logging()
    source_dir = "/path/to/source"
    backup_dir = "/path/to/backups"
    
    create_backup(source_dir, backup_dir)
    cleanup_old_backups(backup_dir)

if __name__ == "__main__":
    main()