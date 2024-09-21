import json
import os
import subprocess

CONFIG_FILE = "/etc/nginx/nginx.conf"
SITES_AVAILABLE = "/etc/nginx/sites-available"
SITES_ENABLED = "/etc/nginx/sites-enabled"

def read_config():
    """Read the current NGINX configuration."""
    try:
        with open(CONFIG_FILE, 'r') as f:
            return f.read()
    except IOError as e:
        return f"Error reading config: {e}"

def write_config(config):
    """Write a new NGINX configuration."""
    try:
        with open(CONFIG_FILE, 'w') as f:
            f.write(config)
        return "Configuration written successfully"
    except IOError as e:
        return f"Error writing config: {e}"

def reload_nginx():
    """Reload NGINX to apply changes."""
    try:
        subprocess.run(["nginx", "-s", "reload"], check=True)
        return "NGINX reloaded successfully"
    except subprocess.CalledProcessError as e:
        return f"Error reloading NGINX: {e}"

def add_upstream(name, servers):
    """Add an upstream block to the NGINX configuration."""
    config = read_config()
    upstream_block = f"\nupstream {name} {{\n"
    for server in servers:
        upstream_block += f"    server {server};\n"
    upstream_block += "}\n"
    
    # Insert the upstream block after the last upstream block or at the start of http block
    http_pos = config.find("http {")
    if http_pos != -1:
        insert_pos = config.rfind("upstream", 0, http_pos)
        if insert_pos != -1:
            insert_pos = config.find("}", insert_pos) + 1
        else:
            insert_pos = http_pos + 6  # length of "http {"
        new_config = config[:insert_pos] + upstream_block + config[insert_pos:]
        return write_config(new_config)
    else:
        return "Error: Could not find http block in NGINX config"

def add_server(server_name, proxy_pass):
    """Add a server block to NGINX sites-available and enable it."""
    config = f"""
server {{
    listen 80;
    server_name {server_name};

    location / {{
        proxy_pass http://{proxy_pass};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }}
}}
"""
    file_path = os.path.join(SITES_AVAILABLE, server_name)
    try:
        with open(file_path, 'w') as f:
            f.write(config)
        os.symlink(file_path, os.path.join(SITES_ENABLED, server_name))
        return f"Server block for {server_name} added and enabled"
    except IOError as e:
        return f"Error adding server block: {e}"

def remove_server(server_name):
    """Remove a server block from NGINX sites-available and sites-enabled."""
    available_path = os.path.join(SITES_AVAILABLE, server_name)
    enabled_path = os.path.join(SITES_ENABLED, server_name)
    try:
        if os.path.exists(enabled_path):
            os.remove(enabled_path)
        if os.path.exists(available_path):
            os.remove(available_path)
        return f"Server block for {server_name} removed"
    except IOError as e:
        return f"Error removing server block: {e}"

def main():
    print("NGINX Load Balancer Configuration")
    print("1. View current config")
    print("2. Add upstream")
    print("3. Add server")
    print("4. Remove server")
    print("5. Reload NGINX")
    print("6. Exit")

    while True:
        choice = input("Enter your choice (1-6): ")
        if choice == "1":
            print(read_config())
        elif choice == "2":
            name = input("Enter upstream name: ")
            servers = input("Enter servers (comma-separated): ").split(',')
            print(add_upstream(name, servers))
        elif choice == "3":
            server_name = input("Enter server name: ")
            proxy_pass = input("Enter proxy_pass: ")
            print(add_server(server_name, proxy_pass))
        elif choice == "4":
            server_name = input("Enter server name to remove: ")
            print(remove_server(server_name))
        elif choice == "5":
            print(reload_nginx())
        elif choice == "6":
            break
        else:
            print("Invalid choice. Please try again.")

if __name__ == "__main__":
    main()