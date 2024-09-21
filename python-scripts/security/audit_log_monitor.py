import os
import time
import json
from datetime import datetime
import re

class AuditLogMonitor:
    def __init__(self, log_file, config_file='audit_config.json'):
        self.log_file = log_file
        self.config_file = config_file
        self.config = self.load_config()
        self.last_position = self.config.get('last_position', 0)

    def load_config(self):
        if os.path.exists(self.config_file):
            with open(self.config_file, 'r') as f:
                return json.load(f)
        return {}

    def save_config(self):
        with open(self.config_file, 'w') as f:
            json.dump(self.config, f)

    def parse_log_entry(self, line):
        # Adjust this regex pattern based on your actual log format
        pattern = r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) \[(\w+)\] (.+)'
        match = re.match(pattern, line)
        if match:
            return {
                'timestamp': match.group(1),
                'level': match.group(2),
                'message': match.group(3)
            }
        return None

    def check_for_suspicious_activity(self, entry):
        suspicious_keywords = ['failed login', 'unauthorized', 'error', 'warning']
        return any(keyword in entry['message'].lower() for keyword in suspicious_keywords)

    def alert(self, entry):
        print(f"ALERT: Suspicious activity detected at {entry['timestamp']}")
        print(f"Level: {entry['level']}")
        print(f"Message: {entry['message']}")
        print("---")

    def monitor(self):
        while True:
            if os.path.exists(self.log_file):
                with open(self.log_file, 'r') as f:
                    f.seek(self.last_position)
                    for line in f:
                        entry = self.parse_log_entry(line)
                        if entry:
                            if self.check_for_suspicious_activity(entry):
                                self.alert(entry)
                    self.last_position = f.tell()

                self.config['last_position'] = self.last_position
                self.save_config()

            time.sleep(10)  # Check every 10 seconds

if __name__ == "__main__":
    log_file = '/var/log/audit/audit.log'  # Adjust this path as needed
    monitor = AuditLogMonitor(log_file)
    try:
        monitor.monitor()
    except KeyboardInterrupt:
        print("Audit log monitoring stopped.")