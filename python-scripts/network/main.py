import argparse
import os
from firewall_management import list_firewall_rules, add_firewall_rule, delete_firewall_rule, block_ip, allow_port
from ip_address_management import list_ip_addresses, add_ip_address, remove_ip_address, is_ip_in_network, get_available_ips
from load_balancer_config import read_config, add_upstream, add_server, remove_server, reload_nginx
from network_config_backup import backup_device_config, backup_all_devices, schedule_backups
from network_usage_monitor import monitor_network

def setup_argparse():
    parser = argparse.ArgumentParser(description="Network Management Tool")
    subparsers = parser.add_subparsers(dest="command", help="Available commands")

    # Firewall management
    firewall_parser = subparsers.add_parser("firewall", help="Firewall management")
    firewall_parser.add_argument("action", choices=["list", "add", "delete", "block", "allow"])
    firewall_parser.add_argument("--chain", help="Firewall chain")
    firewall_parser.add_argument("--rule", help="Firewall rule")
    firewall_parser.add_argument("--ip", help="IP address to block")
    firewall_parser.add_argument("--port", help="Port to allow")

    # IP address management
    ip_parser = subparsers.add_parser("ip", help="IP address management")
    ip_parser.add_argument("action", choices=["list", "add", "remove", "check", "available"])
    ip_parser.add_argument("--interface", help="Network interface")
    ip_parser.add_argument("--ip", help="IP address")
    ip_parser.add_argument("--network", help="Network address")

    # Load balancer configuration
    lb_parser = subparsers.add_parser("loadbalancer", help="Load balancer configuration")
    lb_parser.add_argument("action", choices=["read", "add-upstream", "add-server", "remove-server", "reload"])
    lb_parser.add_argument("--name", help="Upstream or server name")
    lb_parser.add_argument("--servers", help="Comma-separated list of servers")
    lb_parser.add_argument("--proxy-pass", help="Proxy pass for server")

    # Network config backup
    backup_parser = subparsers.add_parser("backup", help="Network config backup")
    backup_parser.add_argument("action", choices=["single", "all", "schedule"])
    backup_parser.add_argument("--device", help="Device IP address")
    backup_parser.add_argument("--devices", help="Comma-separated list of device IP addresses")
    backup_parser.add_argument("--interval", type=int, help="Backup interval in hours")

    # Network usage monitor
    monitor_parser = subparsers.add_parser("monitor", help="Network usage monitor")
    monitor_parser.add_argument("--interval", type=int, default=1, help="Monitoring interval in seconds")
    monitor_parser.add_argument("--duration", type=int, default=3600, help="Monitoring duration in seconds")

    return parser

def main():
    parser = setup_argparse()
    args = parser.parse_args()

    if args.command == "firewall":
        if args.action == "list":
            print(list_firewall_rules())
        elif args.action == "add":
            print(add_firewall_rule(args.chain, args.rule))
        elif args.action == "delete":
            print(delete_firewall_rule(args.chain, args.rule))
        elif args.action == "block":
            print(block_ip(args.ip))
        elif args.action == "allow":
            print(allow_port(args.port))

    elif args.command == "ip":
        if args.action == "list":
            print(list_ip_addresses())
        elif args.action == "add":
            print(add_ip_address(args.interface, args.ip))
        elif args.action == "remove":
            print(remove_ip_address(args.interface, args.ip))
        elif args.action == "check":
            print(is_ip_in_network(args.ip, args.network))
        elif args.action == "available":
            print(get_available_ips(args.network))

    elif args.command == "loadbalancer":
        if args.action == "read":
            print(read_config())
        elif args.action == "add-upstream":
            print(add_upstream(args.name, args.servers.split(",")))
        elif args.action == "add-server":
            print(add_server(args.name, args.proxy_pass))
        elif args.action == "remove-server":
            print(remove_server(args.name))
        elif args.action == "reload":
            print(reload_nginx())

    elif args.command == "backup":
        username = input("Enter username: ")
        password = input("Enter password: ")
        backup_dir = input("Enter backup directory: ")
        if args.action == "single":
            print(backup_device_config(args.device, username, password, backup_dir))
        elif args.action == "all":
            devices = args.devices.split(",")
            print(backup_all_devices(devices, username, password, backup_dir))
        elif args.action == "schedule":
            devices = args.devices.split(",")
            schedule_backups(devices, username, password, backup_dir, args.interval)

    elif args.command == "monitor":
        output_dir = "network_logs"
        os.makedirs(output_dir, exist_ok=True)
        output_file = os.path.join(output_dir, "network_usage.csv")
        monitor_network(args.interval, args.duration, output_file)

if __name__ == "__main__":
    main()