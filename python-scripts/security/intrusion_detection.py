import scapy.all as scapy
from scapy.layers import http
import argparse
import re
import logging
from collections import defaultdict

class IntrusionDetectionSystem:
    def __init__(self, interface):
        self.interface = interface
        self.suspicious_ips = defaultdict(int)
        self.setup_logging()

    def setup_logging(self):
        logging.basicConfig(filename='intrusion_detection.log', level=logging.INFO,
                            format='%(asctime)s - %(levelname)s - %(message)s')

    def sniff_packets(self):
        scapy.sniff(iface=self.interface, store=False, prn=self.process_packet)

    def process_packet(self, packet):
        if packet.haslayer(scapy.IP):
            self.check_ip(packet[scapy.IP])
        if packet.haslayer(http.HTTPRequest):
            self.check_http(packet[http.HTTPRequest])

    def check_ip(self, ip_packet):
        src_ip = ip_packet.src
        dst_ip = ip_packet.dst

        # Check for potential port scanning
        if ip_packet.haslayer(scapy.TCP):
            if ip_packet[scapy.TCP].flags == 2:  # SYN flag
                self.suspicious_ips[src_ip] += 1
                if self.suspicious_ips[src_ip] > 100:
                    self.log_alert(f"Potential port scan detected from {src_ip}")

        # Check for potential DDoS
        if self.suspicious_ips[src_ip] > 1000:
            self.log_alert(f"Potential DDoS attack detected from {src_ip}")

    def check_http(self, http_packet):
        url = http_packet.Host.decode() + http_packet.Path.decode()

        # Check for SQL injection attempts
        if re.search(r"(\w*)\s*(\'|\")?\s*(\s(AND|OR)\s|\-\-|UNION\s+SELECT)", url, re.IGNORECASE):
            self.log_alert(f"Potential SQL injection attempt: {url}")

        # Check for XSS attempts
        if re.search(r"<script\s*>|<script.*?>|<\/script\s*>|alert\s*\(|onclick\s*=", url, re.IGNORECASE):
            self.log_alert(f"Potential XSS attempt: {url}")

    def log_alert(self, message):
        logging.warning(message)
        print(f"ALERT: {message}")

def main():
    parser = argparse.ArgumentParser(description="Network Intrusion Detection System")
    parser.add_argument("-i", "--interface", help="Network interface to sniff on", required=True)
    args = parser.parse_args()

    ids = IntrusionDetectionSystem(args.interface)
    print(f"Starting Intrusion Detection System on interface {args.interface}")
    print("Listening for potential threats...")
    ids.sniff_packets()

if __name__ == "__main__":
    main()