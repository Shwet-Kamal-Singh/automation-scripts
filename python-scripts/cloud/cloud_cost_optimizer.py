import boto3
from azure.identity import DefaultAzureCredential
from azure.mgmt.compute import ComputeManagementClient
from azure.mgmt.resource import ResourceManagementClient
from google.cloud import compute_v1, resourcemanager_v3
from google.oauth2 import service_account
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class CloudCostOptimizer:
    def __init__(self, aws_region, azure_subscription_id, gcp_project_id, gcp_credentials_path):
        # AWS setup
        self.ec2 = boto3.client('ec2', region_name=aws_region)
        
        # Azure setup
        self.azure_credential = DefaultAzureCredential()
        self.azure_compute_client = ComputeManagementClient(self.azure_credential, azure_subscription_id)
        
        # GCP setup
        self.gcp_credentials = service_account.Credentials.from_service_account_file(gcp_credentials_path)
        self.gcp_compute_client = compute_v1.InstancesClient(credentials=self.gcp_credentials)
        self.gcp_project_id = gcp_project_id

    def optimize_aws(self):
        suggestions = []
        
        # Check for stopped instances
        response = self.ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['stopped']}])
        stopped_instances = [instance['InstanceId'] for reservation in response['Reservations'] for instance in reservation['Instances']]
        
        if stopped_instances:
            suggestions.append(f"Consider terminating these stopped EC2 instances to save costs: {', '.join(stopped_instances)}")
        
        # Check for underutilized instances (this is a simplified check, you might want to use CloudWatch metrics for more accurate results)
        response = self.ec2.describe_instances(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
        large_instances = [instance['InstanceId'] for reservation in response['Reservations'] for instance in reservation['Instances'] if instance['InstanceType'].startswith(('c5.', 'm5.', 'r5.'))]
        
        if large_instances:
            suggestions.append(f"Review these potentially underutilized EC2 instances: {', '.join(large_instances)}")
        
        return suggestions

    def optimize_azure(self):
        suggestions = []
        
        # Check for stopped VMs
        vms = list(self.azure_compute_client.virtual_machines.list_all())
        stopped_vms = [vm.name for vm in vms if vm.instance_view and vm.instance_view.statuses and any(status.code == 'PowerState/stopped' for status in vm.instance_view.statuses)]
        
        if stopped_vms:
            suggestions.append(f"Consider deallocating these stopped Azure VMs to save costs: {', '.join(stopped_vms)}")
        
        # Check for potentially underutilized VMs (simplified check)
        large_vms = [vm.name for vm in vms if vm.hardware_profile.vm_size.startswith(('Standard_D', 'Standard_E', 'Standard_F'))]
        
        if large_vms:
            suggestions.append(f"Review these potentially underutilized Azure VMs: {', '.join(large_vms)}")
        
        return suggestions

    def optimize_gcp(self):
        suggestions = []
        
        # Check for stopped instances
        request = compute_v1.ListInstancesRequest(project=self.gcp_project_id, zone='-')
        instances = self.gcp_compute_client.list(request=request)
        stopped_instances = [instance.name for instance in instances if instance.status == 'TERMINATED']
        
        if stopped_instances:
            suggestions.append(f"Consider deleting these stopped GCP instances to save costs: {', '.join(stopped_instances)}")
        
        # Check for potentially underutilized instances (simplified check)
        large_instances = [instance.name for instance in instances if instance.machine_type.split('/')[-1].startswith(('n1-standard-', 'n1-highmem-', 'n1-highcpu-'))]
        
        if large_instances:
            suggestions.append(f"Review these potentially underutilized GCP instances: {', '.join(large_instances)}")
        
        return suggestions

    def get_all_optimizations(self):
        aws_suggestions = self.optimize_aws()
        azure_suggestions = self.optimize_azure()
        gcp_suggestions = self.optimize_gcp()
        
        return {
            'AWS': aws_suggestions,
            'Azure': azure_suggestions,
            'GCP': gcp_suggestions
        }

# Example usage
if __name__ == "__main__":
    optimizer = CloudCostOptimizer(
        aws_region='us-west-2',
        azure_subscription_id='your-azure-subscription-id',
        gcp_project_id='your-gcp-project-id',
        gcp_credentials_path='/path/to/your/gcp-credentials.json'
    )
    
    optimizations = optimizer.get_all_optimizations()
    
    print("Cost Optimization Suggestions:")
    for cloud, suggestions in optimizations.items():
        print(f"\n{cloud}:")
        if suggestions:
            for suggestion in suggestions:
                print(f"  - {suggestion}")
        else:
            print("  No optimization suggestions.")