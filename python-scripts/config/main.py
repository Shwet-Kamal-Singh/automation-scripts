import argparse
import logging
from aws_management import AWSManager
from azure_management import AzureManager
from gcp_management import GCPManager
from cloud_cost_optimizer import CloudCostOptimizer
from config.global_settings import GlobalSettings
from config.api_keys import APIKeyManager

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def initialize_managers(settings, api_keys):
    managers = {}
    if api_keys.get_key('aws'):
        managers['aws'] = AWSManager(
            region=settings.get('aws_region', 'us-west-2'),
            access_key=api_keys.get_key('aws_access_key'),
            secret_key=api_keys.get_key('aws_secret_key')
        )
    if api_keys.get_key('azure'):
        managers['azure'] = AzureManager(
            subscription_id=settings.get('azure_subscription_id'),
            credentials=api_keys.get_key('azure')
        )
    if api_keys.get_key('gcp'):
        managers['gcp'] = GCPManager(
            project_id=settings.get('gcp_project_id'),
            credentials_path=api_keys.get_key('gcp')
        )
    return managers

def list_resources(managers, resource_type):
    for cloud, manager in managers.items():
        print(f"\n{cloud.upper()} {resource_type}:")
        if resource_type == 'instances':
            if cloud == 'aws':
                instances = manager.list_ec2_instances()
            elif cloud == 'azure':
                instances = manager.list_vms()
            elif cloud == 'gcp':
                instances = manager.list_instances(managers['gcp'].zone)
            for instance in instances:
                print(f"  {instance}")
        elif resource_type == 'storage':
            if cloud == 'aws':
                buckets = manager.list_s3_buckets()
            elif cloud == 'azure':
                buckets = manager.list_storage_accounts()
            elif cloud == 'gcp':
                buckets = manager.list_buckets()
            for bucket in buckets:
                print(f"  {bucket}")

def manage_instance(managers, cloud, action, instance_id):
    if cloud not in managers:
        logger.error(f"No credentials found for {cloud}")
        return
    manager = managers[cloud]
    if action == 'start':
        if cloud == 'aws':
            manager.start_ec2_instance(instance_id)
        elif cloud == 'azure':
            manager.start_vm(instance_id)
        elif cloud == 'gcp':
            manager.start_instance(managers['gcp'].zone, instance_id)
    elif action == 'stop':
        if cloud == 'aws':
            manager.stop_ec2_instance(instance_id)
        elif cloud == 'azure':
            manager.stop_vm(instance_id)
        elif cloud == 'gcp':
            manager.stop_instance(managers['gcp'].zone, instance_id)

def optimize_costs(managers, settings):
    optimizer = CloudCostOptimizer(
        aws_region=settings.get('aws_region', 'us-west-2'),
        azure_subscription_id=settings.get('azure_subscription_id'),
        gcp_project_id=settings.get('gcp_project_id'),
        gcp_credentials_path=settings.get('gcp_credentials_path')
    )
    suggestions = optimizer.get_all_optimizations()
    for cloud, cloud_suggestions in suggestions.items():
        print(f"\n{cloud.upper()} Optimization Suggestions:")
        for suggestion in cloud_suggestions:
            print(f"  - {suggestion}")

def main():
    settings = GlobalSettings()
    api_keys = APIKeyManager(encryption_key=settings.get('encryption_key'))

    parser = argparse.ArgumentParser(description="Cloud Management CLI")
    parser.add_argument("--cloud", choices=["aws", "azure", "gcp", "all"], default="all", help="Cloud provider to manage")
    parser.add_argument("--action", choices=["list", "start", "stop", "optimize"], required=True, help="Action to perform")
    parser.add_argument("--resource", choices=["instances", "storage"], help="Resource type for the action")
    parser.add_argument("--id", help="ID of the resource for start/stop actions")
    args = parser.parse_args()

    managers = initialize_managers(settings, api_keys)

    if args.action == "list":
        if not args.resource:
            logger.error("--resource is required for list action")
            return
        list_resources(managers, args.resource)
    elif args.action in ["start", "stop"]:
        if not args.cloud or args.cloud == "all" or not args.id:
            logger.error("--cloud and --id are required for start/stop actions")
            return
        manage_instance(managers, args.cloud, args.action, args.id)
    elif args.action == "optimize":
        optimize_costs(managers, settings)

if __name__ == "__main__":
    main()