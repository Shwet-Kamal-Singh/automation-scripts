import os
import json
from datetime import datetime, timedelta

class AccessControl:
    def __init__(self, users_file='users.json', roles_file='roles.json'):
        self.users_file = users_file
        self.roles_file = roles_file
        self.users = self.load_json(users_file)
        self.roles = self.load_json(roles_file)

    def load_json(self, file_name):
        if os.path.exists(file_name):
            with open(file_name, 'r') as f:
                return json.load(f)
        return {}

    def save_json(self, data, file_name):
        with open(file_name, 'w') as f:
            json.dump(data, f, indent=2)

    def add_user(self, username, password, role):
        if username not in self.users:
            self.users[username] = {
                'password': password,
                'role': role,
                'last_login': None
            }
            self.save_json(self.users, self.users_file)
            return True
        return False

    def remove_user(self, username):
        if username in self.users:
            del self.users[username]
            self.save_json(self.users, self.users_file)
            return True
        return False

    def authenticate(self, username, password):
        if username in self.users and self.users[username]['password'] == password:
            self.users[username]['last_login'] = datetime.now().isoformat()
            self.save_json(self.users, self.users_file)
            return True
        return False

    def add_role(self, role_name, permissions):
        if role_name not in self.roles:
            self.roles[role_name] = permissions
            self.save_json(self.roles, self.roles_file)
            return True
        return False

    def remove_role(self, role_name):
        if role_name in self.roles:
            del self.roles[role_name]
            self.save_json(self.roles, self.roles_file)
            return True
        return False

    def check_permission(self, username, permission):
        if username in self.users:
            user_role = self.users[username]['role']
            if user_role in self.roles:
                return permission in self.roles[user_role]
        return False

    def change_user_role(self, username, new_role):
        if username in self.users and new_role in self.roles:
            self.users[username]['role'] = new_role
            self.save_json(self.users, self.users_file)
            return True
        return False

    def list_users(self):
        return list(self.users.keys())

    def list_roles(self):
        return list(self.roles.keys())

# Example usage
if __name__ == "__main__":
    ac = AccessControl()

    # Add roles
    ac.add_role('admin', ['read', 'write', 'delete'])
    ac.add_role('user', ['read'])

    # Add users
    ac.add_user('alice', 'password123', 'admin')
    ac.add_user('bob', 'password456', 'user')

    # Authenticate
    print(ac.authenticate('alice', 'password123'))  # True
    print(ac.authenticate('bob', 'wrongpassword'))  # False

    # Check permissions
    print(ac.check_permission('alice', 'write'))  # True
    print(ac.check_permission('bob', 'write'))    # False

    # Change user role
    ac.change_user_role('bob', 'admin')
    print(ac.check_permission('bob', 'write'))    # True

    # List users and roles
    print(ac.list_users())
    print(ac.list_roles())