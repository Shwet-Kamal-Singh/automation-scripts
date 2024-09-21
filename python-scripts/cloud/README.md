# Cloud Management Scripts

This directory contains Python scripts for managing resources across multiple cloud providers (AWS, Azure, and GCP) and optimizing cloud costs.

## Files

- `aws_management.py`: Manages AWS EC2 instances and S3 buckets
- `azure_management.py`: Manages Azure Virtual Machines, Resource Groups, and Storage Accounts
- `gcp_management.py`: Manages GCP Compute Engine instances and Cloud Storage buckets
- `cloud_cost_optimizer.py`: Provides cost optimization suggestions for AWS, Azure, and GCP
- `main.py`: Command-line interface to manage resources across all cloud providers

## Setup

1. Install required libraries:
   ```
   pip install boto3 azure-identity azure-mgmt-compute azure-mgmt-resource azure-mgmt-storage google-cloud-compute google-cloud-storage google-cloud-resource-manager
   ```

2. Set up cloud provider credentials:
   - AWS: Configure AWS CLI or set environment variables
   - Azure: Install Azure CLI and login (`az login`) or set up a service principal
   - GCP: Set up a service account key file

3. Create a `config.json` file with your cloud configurations:
   ```json
   {
       "aws": {
           "region": "us-west-2"
       },
       "azure": {
           "subscription_id": "your-azure-subscription-id",
           "resource_group": "your-resource-group-name"
       },
       "gcp": {
           "project_id": "your-gcp-project-id",
           "credentials_path": "/path/to/your/gcp-credentials.json",
           "zone": "us-central1-a"
       }
   }
   ```

## Usage

Use `main.py` to interact with all cloud services:

```
python main.py --action <action> --cloud <cloud_provider> --resource <resource_type> --name <resource_name>
```

Examples:
- List all instances: `python main.py --action list --resource instances`
- List AWS buckets: `python main.py --cloud aws --action list --resource buckets`
- Start Azure VM: `python main.py --cloud azure --action start --name your-vm-name`
- Get cost optimization suggestions: `python main.py --action optimize`

## Notes

- These scripts provide basic functionality. Add error handling and logging as needed.
- Always review and validate cost optimization suggestions before taking action.
- Secure your `config.json` and don't commit it to version control with actual credentials.
- Consider using environment variables or a secrets management solution for production.