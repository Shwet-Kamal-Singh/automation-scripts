import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.mime.application import MIMEApplication
import os
import logging
from typing import List, Optional

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class EmailNotifier:
    def __init__(self, smtp_config: dict):
        self.smtp_config = smtp_config

    def send_email(self, 
                   subject: str, 
                   body: str, 
                   recipients: List[str], 
                   cc: Optional[List[str]] = None, 
                   bcc: Optional[List[str]] = None, 
                   attachments: Optional[List[str]] = None) -> bool:
        try:
            msg = MIMEMultipart()
            msg['From'] = self.smtp_config['sender']
            msg['To'] = ', '.join(recipients)
            msg['Subject'] = subject

            if cc:
                msg['Cc'] = ', '.join(cc)
            if bcc:
                msg['Bcc'] = ', '.join(bcc)

            msg.attach(MIMEText(body, 'plain'))

            if attachments:
                for file in attachments:
                    with open(file, "rb") as f:
                        part = MIMEApplication(f.read(), Name=os.path.basename(file))
                    part['Content-Disposition'] = f'attachment; filename="{os.path.basename(file)}"'
                    msg.attach(part)

            all_recipients = recipients + (cc if cc else []) + (bcc if bcc else [])

            with smtplib.SMTP(self.smtp_config['smtp_server'], self.smtp_config['smtp_port']) as server:
                server.starttls()
                server.login(self.smtp_config['username'], self.smtp_config['password'])
                server.sendmail(self.smtp_config['sender'], all_recipients, msg.as_string())

            logging.info(f"Email sent successfully to {', '.join(all_recipients)}")
            return True
        except Exception as e:
            logging.error(f"Failed to send email: {str(e)}")
            return False

    def send_html_email(self, 
                        subject: str, 
                        html_body: str, 
                        recipients: List[str], 
                        cc: Optional[List[str]] = None, 
                        bcc: Optional[List[str]] = None, 
                        attachments: Optional[List[str]] = None) -> bool:
        try:
            msg = MIMEMultipart('alternative')
            msg['From'] = self.smtp_config['sender']
            msg['To'] = ', '.join(recipients)
            msg['Subject'] = subject

            if cc:
                msg['Cc'] = ', '.join(cc)
            if bcc:
                msg['Bcc'] = ', '.join(bcc)

            msg.attach(MIMEText(html_body, 'html'))

            if attachments:
                for file in attachments:
                    with open(file, "rb") as f:
                        part = MIMEApplication(f.read(), Name=os.path.basename(file))
                    part['Content-Disposition'] = f'attachment; filename="{os.path.basename(file)}"'
                    msg.attach(part)

            all_recipients = recipients + (cc if cc else []) + (bcc if bcc else [])

            with smtplib.SMTP(self.smtp_config['smtp_server'], self.smtp_config['smtp_port']) as server:
                server.starttls()
                server.login(self.smtp_config['username'], self.smtp_config['password'])
                server.sendmail(self.smtp_config['sender'], all_recipients, msg.as_string())

            logging.info(f"HTML email sent successfully to {', '.join(all_recipients)}")
            return True
        except Exception as e:
            logging.error(f"Failed to send HTML email: {str(e)}")
            return False

# Example usage
if __name__ == "__main__":
    smtp_config = {
        'sender': 'sender@example.com',
        'smtp_server': 'smtp.example.com',
        'smtp_port': 587,
        'username': 'your_username',
        'password': 'your_password'
    }

    notifier = EmailNotifier(smtp_config)

    # Send a plain text email
    notifier.send_email(
        subject="Test Email",
        body="This is a test email sent from the EmailNotifier class.",
        recipients=["recipient1@example.com", "recipient2@example.com"],
        cc=["cc@example.com"],
        bcc=["bcc@example.com"],
        attachments=["path/to/attachment.pdf"]
    )

    # Send an HTML email
    html_body = """
    <html>
      <body>
        <h1>Test HTML Email</h1>
        <p>This is a <b>test HTML email</b> sent from the EmailNotifier class.</p>
      </body>
    </html>
    """
    notifier.send_html_email(
        subject="Test HTML Email",
        html_body=html_body,
        recipients=["recipient1@example.com", "recipient2@example.com"],
        cc=["cc@example.com"],
        bcc=["bcc@example.com"],
        attachments=["path/to/attachment.pdf"]
    )