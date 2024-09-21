import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import requests
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class NotificationManager:
    def __init__(self, config):
        self.config = config

    def send_email(self, subject, message, recipient):
        try:
            msg = MIMEMultipart()
            msg['From'] = self.config['email']['sender']
            msg['To'] = recipient
            msg['Subject'] = subject
            msg.attach(MIMEText(message, 'plain'))

            server = smtplib.SMTP(self.config['email']['smtp_server'], self.config['email']['smtp_port'])
            server.starttls()
            server.login(self.config['email']['username'], self.config['email']['password'])
            server.send_message(msg)
            server.quit()
            logging.info(f"Email sent to {recipient}")
        except Exception as e:
            logging.error(f"Failed to send email: {str(e)}")

    def send_slack(self, message, channel):
        try:
            payload = {
                "text": message,
                "channel": channel
            }
            response = requests.post(
                self.config['slack']['webhook_url'],
                json=payload
            )
            if response.status_code == 200:
                logging.info(f"Slack message sent to {channel}")
            else:
                logging.error(f"Failed to send Slack message: {response.text}")
        except Exception as e:
            logging.error(f"Failed to send Slack message: {str(e)}")

    def send_sms(self, message, phone_number):
        # Implement SMS sending logic here
        # This is a placeholder and will depend on your SMS service provider
        logging.info(f"SMS sent to {phone_number}: {message}")

    def notify(self, notification_type, subject, message, recipient):
        if notification_type == 'email':
            self.send_email(subject, message, recipient)
        elif notification_type == 'slack':
            self.send_slack(message, recipient)  # recipient is channel in this case
        elif notification_type == 'sms':
            self.send_sms(message, recipient)  # recipient is phone number in this case
        else:
            logging.error(f"Unknown notification type: {notification_type}")

# Example usage
if __name__ == "__main__":
    config = {
        'email': {
            'sender': 'sender@example.com',
            'smtp_server': 'smtp.example.com',
            'smtp_port': 587,
            'username': 'your_username',
            'password': 'your_password'
        },
        'slack': {
            'webhook_url': 'https://hooks.slack.com/services/YOUR/WEBHOOK/URL'
        }
    }

    notifier = NotificationManager(config)
    notifier.notify('email', 'Test Subject', 'This is a test email', 'recipient@example.com')
    notifier.notify('slack', '', 'This is a test Slack message', '#general')
    notifier.notify('sms', '', 'This is a test SMS', '+1234567890')