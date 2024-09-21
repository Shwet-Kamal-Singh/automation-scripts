import os
import time
import logging
from datetime import datetime, timedelta
from typing import List, Optional

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class TempFileCleanup:
    def __init__(self, directories: List[str], file_extensions: Optional[List[str]] = None, max_age_days: int = 7):
        self.directories = directories
        self.file_extensions = file_extensions or []
        self.max_age = timedelta(days=max_age_days)

    def is_old_file(self, file_path: str) -> bool:
        """Check if a file is older than the maximum age."""
        file_time = os.path.getmtime(file_path)
        file_datetime = datetime.fromtimestamp(file_time)
        return datetime.now() - file_datetime > self.max_age

    def should_delete(self, file_path: str) -> bool:
        """Determine if a file should be deleted based on age and extension."""
        if not self.is_old_file(file_path):
            return False
        if not self.file_extensions:
            return True
        return any(file_path.endswith(ext) for ext in self.file_extensions)

    def cleanup_directory(self, directory: str) -> None:
        """Clean up temporary files in a single directory."""
        try:
            for root, _, files in os.walk(directory):
                for file in files:
                    file_path = os.path.join(root, file)
                    if self.should_delete(file_path):
                        try:
                            os.remove(file_path)
                            logging.info(f"Deleted: {file_path}")
                        except Exception as e:
                            logging.error(f"Failed to delete {file_path}: {str(e)}")
        except Exception as e:
            logging.error(f"Error cleaning up directory {directory}: {str(e)}")

    def cleanup_all_directories(self) -> None:
        """Clean up temporary files in all specified directories."""
        for directory in self.directories:
            if os.path.exists(directory):
                logging.info(f"Cleaning up directory: {directory}")
                self.cleanup_directory(directory)
            else:
                logging.warning(f"Directory does not exist: {directory}")

    def run_cleanup(self, interval_hours: int = 24) -> None:
        """Run the cleanup process at specified intervals."""
        while True:
            logging.info("Starting cleanup process")
            self.cleanup_all_directories()
            logging.info(f"Cleanup complete. Sleeping for {interval_hours} hours")
            time.sleep(interval_hours * 3600)  # Convert hours to seconds

# Example usage
if __name__ == "__main__":
    temp_directories = [
        "/tmp",
        "/var/tmp",
        "C:\\Windows\\Temp"  # Windows temp directory
    ]
    file_extensions = [".tmp", ".temp", ".log"]
    
    cleaner = TempFileCleanup(
        directories=temp_directories,
        file_extensions=file_extensions,
        max_age_days=7
    )
    
    # Run once
    cleaner.cleanup_all_directories()
    
    # Or run continuously with a 24-hour interval
    # cleaner.run_cleanup(interval_hours=24)