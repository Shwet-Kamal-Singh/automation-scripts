import ipaddress
import subprocess
import re

def list_ip_addresses():
    """List all IP addresses assigned to network interfaces."""
    try:
        output = subprocess.check_output(["ip", "addr", "show"]).decode("utf-8")
        ip_list = re.findall(r"inet\s+(\d+\.\d+\.\d+\.\d+/\d+)", output)
        return ip_list
    except subprocess.CalledProcessError as e:
        return f"Error listing IP addresses: {e}"

def add_ip_address(interface, ip_address):
    """Add an IP address to a network interface."""
    try:
        subprocess.run(["ip", "addr", "add", ip_address, "dev", interface], check=True)
        return f"IP address {ip_address} added to {interface}"
    except subprocess.CalledProcessError as e:
        return f"Error adding IP address: {e}"

def remove_ip_address(interface, ip_address):
    """Remove an IP address from a network interface."""
    try:
        subprocess.run(["ip", "addr", "del", ip_address, "dev", interface], check=True)
        return f"IP address {ip_address} removed from {interface}"
    except subprocess.CalledProcessError as e:
        return f"Error removing IP address: {e}"

def is_ip_in_network(ip, network):
    """Check if an IP address is within a given network."""
    try:
        return ipaddress.ip_address(ip) in ipaddress.ip_network(network)
    except ValueError as e:
        return f"Error: {e}"

def get_available_ips(network, exclude_ips=[]):
    """Get available IP addresses in a network, excluding specified IPs."""
    try:
        net = ipaddress.ip_network(network)
        all_ips = set(net.hosts())
        excluded = set(ipaddress.ip_address(ip) for ip in exclude_ips)
        available = all_ips - excluded
        return [str(ip) for ip in available]
    except ValueError as e:
        return f"Error: {e}"

def main():
    print("IP Address Management Script")
    print("1. List IP addresses")
    print("2. Add IP address")
    print("3. Remove IP address")
    print("4. Check if IP is in network")
    print("5. Get available IPs in network")
    print("6. Exit")

    while True:
        choice = input("Enter your choice (1-6): ")
        if choice == "1":
            print("IP addresses:", list_ip_addresses())
        elif choice == "2":
            interface = input("Enter interface name: ")
            ip = input("Enter IP address with subnet (e.g., 192.168.1.10/24): ")
            print(add_ip_address(interface, ip))
        elif choice == "3":
            interface = input("Enter interface name: ")
            ip = input("Enter IP address with subnet to remove: ")
            print(remove_ip_address(interface, ip))
        elif choice == "4":
            ip = input("Enter IP address: ")
            network = input("Enter network (e.g., 192.168.1.0/24): ")
            print("Is IP in network:", is_ip_in_network(ip, network))
        elif choice == "5":
            network = input("Enter network (e.g., 192.168.1.0/24): ")
            exclude = input("Enter IPs to exclude (comma-separated, or press Enter for none): ")
            exclude_ips = [ip.strip() for ip in exclude.split(",")] if exclude else []
            available = get_available_ips(network, exclude_ips)
            print(f"Available IPs in {network}:", available[:10], "..." if len(available) > 10 else "")
        elif choice == "6":
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()