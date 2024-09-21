from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.storage import StorageManagementClient
from azure.core.exceptions import AzureError
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class AzureManager:
    def __init__(self, subscription_id):
        self.subscription_id = subscription_id
        self.credential = DefaultAzureCredential()
        self.compute_client = ComputeManagementClient(self.credential, self.subscription_id)
        self.resource_client = ResourceManagementClient(self.credential, self.subscription_id)
        self.storage_client = StorageManagementClient(self.credential, self.subscription_id)

    def list_vms(self):
        try:
            vms = list(self.compute_client.virtual_machines.list_all())
            return [{'name': vm.name, 'location': vm.location, 'vm_size': vm.hardware_profile.vm_size} for vm in vms]
        except AzureError as e:
            logger.error(f"Error listing VMs: {e}")
            return []

    def start_vm(self, resource_group_name, vm_name):
        try:
            self.compute_client.virtual_machines.begin_start(resource_group_name, vm_name).result()
            logger.info(f"Started VM: {vm_name}")
        except AzureError as e:
            logger.error(f"Error starting VM {vm_name}: {e}")

    def stop_vm(self, resource_group_name, vm_name):
        try:
            self.compute_client.virtual_machines.begin_deallocate(resource_group_name, vm_name).result()
            logger.info(f"Stopped VM: {vm_name}")
        except AzureError as e:
            logger.error(f"Error stopping VM {vm_name}: {e}")

    def list_resource_groups(self):
        try:
            groups = list(self.resource_client.resource_groups.list())
            return [{'name': group.name, 'location': group.location} for group in groups]
        except AzureError as e:
            logger.error(f"Error listing resource groups: {e}")
            return []

    def list_storage_accounts(self):
        try:
            accounts = list(self.storage_client.storage_accounts.list())
            return [{'name': account.name, 'location': account.location, 'sku': account.sku.name} for account in accounts]
        except AzureError as e:
            logger.error(f"Error listing storage accounts: {e}")
            return []

    def create_storage_account(self, resource_group_name, account_name, location, sku='Standard_LRS'):
        try:
            poller = self.storage_client.storage_accounts.begin_create(
                resource_group_name,
                account_name,
                {
                    'location': location,
                    'kind': 'StorageV2',
                    'sku': {'name': sku}
                }
            )
            account_result = poller.result()
            logger.info(f"Created storage account: {account_result.name}")
        except AzureError as e:
            logger.error(f"Error creating storage account {account_name}: {e}")

# Example usage
if __name__ == "__main__":
    subscription_id = 'your-subscription-id'
    azure_manager = AzureManager(subscription_id)
    
    # List VMs
    vms = azure_manager.list_vms()
    print("Virtual Machines:")
    for vm in vms:
        print(f"  {vm['name']} - {vm['location']} - {vm['vm_size']}")
    
    # List Resource Groups
    groups = azure_manager.list_resource_groups()
    print("\nResource Groups:")
    for group in groups:
        print(f"  {group['name']} - {group['location']}")

    # List Storage Accounts
    accounts = azure_manager.list_storage_accounts()
    print("\nStorage Accounts:")
    for account in accounts:
        print(f"  {account['name']} - {account['location']} - {account['sku']}")

    # Uncomment to test other functions
    # azure_manager.start_vm('myResourceGroup', 'myVM')
    # azure_manager.stop_vm('myResourceGroup', 'myVM')
    # azure_manager.create_storage_account('myResourceGroup', 'mystorageaccount', 'eastus')