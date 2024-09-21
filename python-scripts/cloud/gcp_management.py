from google.cloud import compute_v1, storage_v1
from google.oauth2 import service_account
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class GCPManager:
    def __init__(self, project_id, credentials_path):
        self.project_id = project_id
        self.credentials = service_account.Credentials.from_service_account_file(credentials_path)
        self.compute_client = compute_v1.InstancesClient(credentials=self.credentials)
        self.storage_client = storage_v1.StorageClient(credentials=self.credentials)

    def list_instances(self, zone):
        try:
            request = compute_v1.ListInstancesRequest(
                project=self.project_id,
                zone=zone
            )
            instances = self.compute_client.list(request=request)
            return [
                {
                    'name': instance.name,
                    'machine_type': instance.machine_type.split('/')[-1],
                    'status': instance.status
                }
                for instance in instances
            ]
        except Exception as e:
            logger.error(f"Error listing instances: {e}")
            return []

    def start_instance(self, zone, instance_name):
        try:
            request = compute_v1.StartInstanceRequest(
                project=self.project_id,
                zone=zone,
                instance=instance_name
            )
            operation = self.compute_client.start(request=request)
            operation.result()  # Wait for operation to complete
            logger.info(f"Started instance: {instance_name}")
        except Exception as e:
            logger.error(f"Error starting instance {instance_name}: {e}")

    def stop_instance(self, zone, instance_name):
        try:
            request = compute_v1.StopInstanceRequest(
                project=self.project_id,
                zone=zone,
                instance=instance_name
            )
            operation = self.compute_client.stop(request=request)
            operation.result()  # Wait for operation to complete
            logger.info(f"Stopped instance: {instance_name}")
        except Exception as e:
            logger.error(f"Error stopping instance {instance_name}: {e}")

    def list_buckets(self):
        try:
            buckets = self.storage_client.list_buckets(project=self.project_id)
            return [bucket.name for bucket in buckets]
        except Exception as e:
            logger.error(f"Error listing buckets: {e}")
            return []

    def create_bucket(self, bucket_name, location="US"):
        try:
            bucket = storage_v1.Bucket(name=bucket_name, location=location)
            self.storage_client.create_bucket(bucket=bucket, project=self.project_id)
            logger.info(f"Created bucket: {bucket_name}")
        except Exception as e:
            logger.error(f"Error creating bucket {bucket_name}: {e}")

    def delete_bucket(self, bucket_name):
        try:
            self.storage_client.delete_bucket(bucket=bucket_name)
            logger.info(f"Deleted bucket: {bucket_name}")
        except Exception as e:
            logger.error(f"Error deleting bucket {bucket_name}: {e}")

# Example usage
if __name__ == "__main__":
    gcp_manager = GCPManager(
        project_id='your-project-id',
        credentials_path='/path/to/your/credentials.json'
    )

    # List instances in a specific zone
    instances = gcp_manager.list_instances('us-central1-a')
    print("Compute Engine Instances:")
    for instance in instances:
        print(f"  {instance['name']} - {instance['machine_type']} - {instance['status']}")

    # List buckets
    buckets = gcp_manager.list_buckets()
    print("\nCloud Storage Buckets:")
    for bucket in buckets:
        print(f"  {bucket}")

    # Uncomment to test other functions
    # gcp_manager.start_instance('us-central1-a', 'instance-name')
    # gcp_manager.stop_instance('us-central1-a', 'instance-name')
    # gcp_manager.create_bucket('my-new-bucket-name')
    # gcp_manager.delete_bucket('bucket-to-delete')