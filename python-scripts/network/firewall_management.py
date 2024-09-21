import subprocess
import re

def list_firewall_rules():
    """List all firewall rules."""
    try:
        output = subprocess.check_output(["iptables", "-L", "-n"]).decode("utf-8")
        return output
    except subprocess.CalledProcessError as e:
        return f"Error listing firewall rules: {e}"

def add_firewall_rule(chain, rule):
    """Add a new firewall rule."""
    try:
        subprocess.run(["iptables", "-A", chain] + rule.split(), check=True)
        return "Rule added successfully"
    except subprocess.CalledProcessError as e:
        return f"Error adding firewall rule: {e}"

def delete_firewall_rule(chain, rule_number):
    """Delete a firewall rule by its number in the chain."""
    try:
        subprocess.run(["iptables", "-D", chain, str(rule_number)], check=True)
        return "Rule deleted successfully"
    except subprocess.CalledProcessError as e:
        return f"Error deleting firewall rule: {e}"

def flush_firewall_rules():
    """Flush all firewall rules."""
    try:
        subprocess.run(["iptables", "-F"], check=True)
        return "All firewall rules flushed successfully"
    except subprocess.CalledProcessError as e:
        return f"Error flushing firewall rules: {e}"

def block_ip(ip_address):
    """Block a specific IP address."""
    return add_firewall_rule("INPUT", f"-s {ip_address} -j DROP")

def allow_port(port, protocol="tcp"):
    """Allow incoming traffic on a specific port."""
    return add_firewall_rule("INPUT", f"-p {protocol} --dport {port} -j ACCEPT")

def get_blocked_ips():
    """Get a list of blocked IP addresses."""
    output = list_firewall_rules()
    blocked_ips = re.findall(r"DROP\s+all\s+--\s+(\d+\.\d+\.\d+\.\d+)", output)
    return blocked_ips

def main():
    print("Firewall Management Script")
    print("1. List firewall rules")
    print("2. Add firewall rule")
    print("3. Delete firewall rule")
    print("4. Flush all rules")
    print("5. Block IP")
    print("6. Allow port")
    print("7. Get blocked IPs")
    print("8. Exit")

    while True:
        choice = input("Enter your choice (1-8): ")
        if choice == "1":
            print(list_firewall_rules())
        elif choice == "2":
            chain = input("Enter chain (INPUT/OUTPUT/FORWARD): ")
            rule = input("Enter rule: ")
            print(add_firewall_rule(chain, rule))
        elif choice == "3":
            chain = input("Enter chain (INPUT/OUTPUT/FORWARD): ")
            rule_number = input("Enter rule number: ")
            print(delete_firewall_rule(chain, rule_number))
        elif choice == "4":
            print(flush_firewall_rules())
        elif choice == "5":
            ip = input("Enter IP address to block: ")
            print(block_ip(ip))
        elif choice == "6":
            port = input("Enter port to allow: ")
            protocol = input("Enter protocol (tcp/udp): ")
            print(allow_port(port, protocol))
        elif choice == "7":
            print("Blocked IPs:", get_blocked_ips())
        elif choice == "8":
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()