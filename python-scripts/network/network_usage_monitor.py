import psutil
import time
from datetime import datetime
import csv
import os

def get_network_usage():
    """Get current network usage statistics."""
    return psutil.net_io_counters()

def calculate_speed(old, new, interval):
    """Calculate network speed in MB/s."""
    return (new - old) / interval / 1024 / 1024

def monitor_network(interval, duration, output_file):
    """Monitor network usage for a specified duration."""
    start_time = time.time()
    end_time = start_time + duration

    # Prepare CSV file
    fieldnames = ['Timestamp', 'Bytes Sent (MB)', 'Bytes Recv (MB)', 'Packets Sent', 'Packets Recv', 'Send Speed (MB/s)', 'Recv Speed (MB/s)']
    with open(output_file, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        # Initial network stats
        last_stats = get_network_usage()
        last_time = start_time

        while time.time() < end_time:
            time.sleep(interval)
            
            current_time = time.time()
            current_stats = get_network_usage()

            # Calculate speeds
            send_speed = calculate_speed(last_stats.bytes_sent, current_stats.bytes_sent, interval)
            recv_speed = calculate_speed(last_stats.bytes_recv, current_stats.bytes_recv, interval)

            # Write to CSV
            writer.writerow({
                'Timestamp': datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                'Bytes Sent (MB)': current_stats.bytes_sent / 1024 / 1024,
                'Bytes Recv (MB)': current_stats.bytes_recv / 1024 / 1024,
                'Packets Sent': current_stats.packets_sent,
                'Packets Recv': current_stats.packets_recv,
                'Send Speed (MB/s)': send_speed,
                'Recv Speed (MB/s)': recv_speed
            })

            # Update last stats
            last_stats = current_stats
            last_time = current_time

            # Print current stats
            print(f"Send Speed: {send_speed:.2f} MB/s, Recv Speed: {recv_speed:.2f} MB/s")

def main():
    interval = 1  # seconds
    duration = 3600  # 1 hour
    output_dir = "network_logs"
    os.makedirs(output_dir, exist_ok=True)
    output_file = os.path.join(output_dir, f"network_usage_{datetime.now().strftime('%Y%m%d_%H%M%S')}.csv")

    print(f"Starting network monitoring. Data will be saved to {output_file}")
    print("Press Ctrl+C to stop monitoring.")

    try:
        monitor_network(interval, duration, output_file)
    except KeyboardInterrupt:
        print("\nMonitoring stopped by user.")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        print(f"Monitoring complete. Data saved to {output_file}")

if __name__ == "__main__":
    main()