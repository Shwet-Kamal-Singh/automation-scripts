import argparse
import json
from aws_management import AWSManager
from azure_management import AzureManager
from gcp_management import GCPManager
from cloud_cost_optimizer import CloudCostOptimizer
import logging

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def load_config(config_file):
    with open(config_file, 'r') as f:
        return json.load(f)

def main():
    parser = argparse.ArgumentParser(description="Cloud Management CLI")
    parser.add_argument("--config", default="config.json", help="Path to configuration file")
    parser.add_argument("--cloud", choices=["aws", "azure", "gcp", "all"], default="all", help="Cloud provider to manage")
    parser.add_argument("--action", choices=["list", "start", "stop", "optimize"], required=True, help="Action to perform")
    parser.add_argument("--resource", choices=["instances", "buckets"], help="Resource type for the action")
    parser.add_argument("--name", help="Name of the resource for start/stop actions")
    args = parser.parse_args()

    config = load_config(args.config)

    if args.cloud in ["aws", "all"]:
        aws_manager = AWSManager()
    if args.cloud in ["azure", "all"]:
        azure_manager = AzureManager(config['azure']['subscription_id'])
    if args.cloud in ["gcp", "all"]:
        gcp_manager = GCPManager(config['gcp']['project_id'], config['gcp']['credentials_path'])

    if args.action == "list":
        if args.resource == "instances":
            if args.cloud in ["aws", "all"]:
                print("AWS EC2 Instances:")
                for instance in aws_manager.list_ec2_instances():
                    print(f"  {instance['InstanceId']} - {instance['InstanceType']} - {instance['State']}")
            if args.cloud in ["azure", "all"]:
                print("\nAzure VMs:")
                for vm in azure_manager.list_vms():
                    print(f"  {vm['name']} - {vm['location']} - {vm['vm_size']}")
            if args.cloud in ["gcp", "all"]:
                print("\nGCP Compute Engine Instances:")
                for instance in gcp_manager.list_instances(config['gcp']['zone']):
                    print(f"  {instance['name']} - {instance['machine_type']} - {instance['status']}")
        elif args.resource == "buckets":
            if args.cloud in ["aws", "all"]:
                print("AWS S3 Buckets:")
                for bucket in aws_manager.list_s3_buckets():
                    print(f"  {bucket}")
            if args.cloud in ["azure", "all"]:
                print("\nAzure Storage Accounts:")
                for account in azure_manager.list_storage_accounts():
                    print(f"  {account['name']} - {account['location']} - {account['sku']}")
            if args.cloud in ["gcp", "all"]:
                print("\nGCP Cloud Storage Buckets:")
                for bucket in gcp_manager.list_buckets():
                    print(f"  {bucket}")

    elif args.action in ["start", "stop"]:
        if not args.name:
            logger.error("--name argument is required for start/stop actions")
            return
        if args.cloud == "aws":
            if args.action == "start":
                aws_manager.start_ec2_instance(args.name)
            else:
                aws_manager.stop_ec2_instance(args.name)
        elif args.cloud == "azure":
            if args.action == "start":
                azure_manager.start_vm(config['azure']['resource_group'], args.name)
            else:
                azure_manager.stop_vm(config['azure']['resource_group'], args.name)
        elif args.cloud == "gcp":
            if args.action == "start":
                gcp_manager.start_instance(config['gcp']['zone'], args.name)
            else:
                gcp_manager.stop_instance(config['gcp']['zone'], args.name)
        else:
            logger.error("Please specify a single cloud provider for start/stop actions")

    elif args.action == "optimize":
        optimizer = CloudCostOptimizer(
            aws_region=config['aws']['region'],
            azure_subscription_id=config['azure']['subscription_id'],
            gcp_project_id=config['gcp']['project_id'],
            gcp_credentials_path=config['gcp']['credentials_path']
        )
        optimizations = optimizer.get_all_optimizations()
        print("Cost Optimization Suggestions:")
        for cloud, suggestions in optimizations.items():
            if args.cloud in [cloud.lower(), "all"]:
                print(f"\n{cloud}:")
                if suggestions:
                    for suggestion in suggestions:
                        print(f"  - {suggestion}")
                else:
                    print("  No optimization suggestions.")

if __name__ == "__main__":
    main()