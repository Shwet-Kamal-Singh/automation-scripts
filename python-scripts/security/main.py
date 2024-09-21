import argparse
import logging
from access_control import AccessControl
from audit_log_monitor import AuditLogMonitor
from encryption_management import EncryptionManager
from intrusion_detection import IntrusionDetectionSystem
from security_patch_management import SecurityPatchManager
from vulnerability_scan import VulnerabilityScanner

def setup_logging():
    logging.basicConfig(
        filename='security_suite.log',
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )

def main():
    setup_logging()
    logger = logging.getLogger('main')

    parser = argparse.ArgumentParser(description="Security Suite")
    parser.add_argument('--action', choices=['access', 'audit', 'encrypt', 'ids', 'patch', 'scan'], required=True)
    parser.add_argument('--target', help="Target for vulnerability scan or IDS")
    parser.add_argument('--interface', help="Network interface for IDS")
    args = parser.parse_args()

    try:
        if args.action == 'access':
            ac = AccessControl()
            # Example usage
            ac.add_role('admin', ['read', 'write', 'delete'])
            ac.add_user('alice', 'password123', 'admin')
            print(ac.authenticate('alice', 'password123'))
            print(ac.check_permission('alice', 'write'))

        elif args.action == 'audit':
            log_file = '/var/log/audit/audit.log'  # Adjust as needed
            monitor = AuditLogMonitor(log_file)
            monitor.monitor()

        elif args.action == 'encrypt':
            em = EncryptionManager()
            # Example usage
            secret = "This is a secret message."
            encrypted = em.encrypt_string(secret)
            decrypted = em.decrypt_string(encrypted)
            print(f"Original: {secret}")
            print(f"Encrypted: {encrypted}")
            print(f"Decrypted: {decrypted}")

        elif args.action == 'ids':
            if not args.interface:
                raise ValueError("Network interface is required for IDS")
            ids = IntrusionDetectionSystem(args.interface)
            ids.sniff_packets()

        elif args.action == 'patch':
            patch_manager = SecurityPatchManager()
            patch_manager.run_patch_cycle()

        elif args.action == 'scan':
            if not args.target:
                raise ValueError("Target is required for vulnerability scan")
            scanner = VulnerabilityScanner(args.target)
            scanner.run_scan()

    except Exception as e:
        logger.error(f"An error occurred: {str(e)}")
        print(f"An error occurred. Check the log file for details.")

if __name__ == "__main__":
    main()