import boto3
from botocore.exceptions import ClientError
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class AWSManager:
    def __init__(self):
        self.ec2 = boto3.client('ec2')
        self.s3 = boto3.client('s3')

    def list_ec2_instances(self):
        try:
            response = self.ec2.describe_instances()
            instances = []
            for reservation in response['Reservations']:
                for instance in reservation['Instances']:
                    instances.append({
                        'InstanceId': instance['InstanceId'],
                        'InstanceType': instance['InstanceType'],
                        'State': instance['State']['Name']
                    })
            return instances
        except ClientError as e:
            logger.error(f"Error listing EC2 instances: {e}")
            return []

    def start_ec2_instance(self, instance_id):
        try:
            self.ec2.start_instances(InstanceIds=[instance_id])
            logger.info(f"Started EC2 instance: {instance_id}")
        except ClientError as e:
            logger.error(f"Error starting EC2 instance {instance_id}: {e}")

    def stop_ec2_instance(self, instance_id):
        try:
            self.ec2.stop_instances(InstanceIds=[instance_id])
            logger.info(f"Stopped EC2 instance: {instance_id}")
        except ClientError as e:
            logger.error(f"Error stopping EC2 instance {instance_id}: {e}")

    def list_s3_buckets(self):
        try:
            response = self.s3.list_buckets()
            return [bucket['Name'] for bucket in response['Buckets']]
        except ClientError as e:
            logger.error(f"Error listing S3 buckets: {e}")
            return []

    def create_s3_bucket(self, bucket_name, region='us-west-2'):
        try:
            self.s3.create_bucket(
                Bucket=bucket_name,
                CreateBucketConfiguration={'LocationConstraint': region}
            )
            logger.info(f"Created S3 bucket: {bucket_name}")
        except ClientError as e:
            logger.error(f"Error creating S3 bucket {bucket_name}: {e}")

# Example usage
if __name__ == "__main__":
    aws_manager = AWSManager()
    
    # List EC2 instances
    instances = aws_manager.list_ec2_instances()
    print("EC2 Instances:")
    for instance in instances:
        print(f"  {instance['InstanceId']} - {instance['InstanceType']} - {instance['State']}")
    
    # List S3 buckets
    buckets = aws_manager.list_s3_buckets()
    print("\nS3 Buckets:")
    for bucket in buckets:
        print(f"  {bucket}")

    # Uncomment to test other functions
    # aws_manager.start_ec2_instance('i-1234567890abcdef0')
    # aws_manager.stop_ec2_instance('i-1234567890abcdef0')
    # aws_manager.create_s3_bucket('my-new-bucket-name')