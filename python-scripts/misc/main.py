import argparse
import logging
from custom_notifications import NotificationManager
from email_notifications import EmailNotifier
from service_dependency_mapping import ServiceDependencyMapper
from temp_file_cleanup import TempFileCleanup
import yaml

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def load_config(config_file):
    try:
        with open(config_file, 'r') as file:
            return yaml.safe_load(file)
    except Exception as e:
        logging.error(f"Failed to load configuration: {str(e)}")
        raise

def run_custom_notifications(config):
    notifier = NotificationManager(config['notifications'])
    notifier.notify('email', 'Test Subject', 'This is a test email', 'recipient@example.com')
    notifier.notify('slack', '', 'This is a test Slack message', '#general')

def run_email_notifications(config):
    email_notifier = EmailNotifier(config['email'])
    email_notifier.send_email(
        subject="Test Email",
        body="This is a test email sent from the main script.",
        recipients=["recipient@example.com"],
    )

def run_service_dependency_mapping(config):
    mapper = ServiceDependencyMapper(config['service_dependency']['config_file'])
    mapper.load_config()
    mapper.build_graph()
    mapper.visualize_graph(config['service_dependency']['output_file'])
    circular_deps = mapper.find_circular_dependencies()
    if circular_deps:
        logging.warning(f"Circular dependencies found: {circular_deps}")

def run_temp_file_cleanup(config):
    cleaner = TempFileCleanup(
        directories=config['temp_file_cleanup']['directories'],
        file_extensions=config['temp_file_cleanup']['file_extensions'],
        max_age_days=config['temp_file_cleanup']['max_age_days']
    )
    cleaner.cleanup_all_directories()

def main():
    parser = argparse.ArgumentParser(description="Run various system management scripts")
    parser.add_argument('--config', default='config.yaml', help='Path to the configuration file')
    parser.add_argument('--notifications', action='store_true', help='Run custom notifications')
    parser.add_argument('--email', action='store_true', help='Run email notifications')
    parser.add_argument('--dependencies', action='store_true', help='Run service dependency mapping')
    parser.add_argument('--cleanup', action='store_true', help='Run temporary file cleanup')
    args = parser.parse_args()

    config = load_config(args.config)

    if args.notifications:
        run_custom_notifications(config)
    
    if args.email:
        run_email_notifications(config)
    
    if args.dependencies:
        run_service_dependency_mapping(config)
    
    if args.cleanup:
        run_temp_file_cleanup(config)

    if not (args.notifications or args.email or args.dependencies or args.cleanup):
        logging.warning("No specific task selected. Use --help for usage information.")

if __name__ == "__main__":
    main()