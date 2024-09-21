import logging
from db_postgresql_backup import postgres_backup
from db_mysql_backup import mysql_backup
from db_performance_monitor import monitor_postgres, monitor_mysql
from query_optimizer import main as optimize_query
import schedule
import time

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Database configurations
PG_CONFIG = {
    "host": "localhost",
    "port": "5432",
    "user": "pg_user",
    "password": "pg_password",
    "database": "pg_database",
    "backup_dir": "/path/to/pg_backups"
}

MYSQL_CONFIG = {
    "host": "localhost",
    "port": "3306",
    "user": "mysql_user",
    "password": "mysql_password",
    "database": "mysql_database",
    "backup_dir": "/path/to/mysql_backups"
}

def run_backups():
    logging.info("Running database backups...")
    postgres_backup(**PG_CONFIG)
    mysql_backup(**MYSQL_CONFIG)

def run_performance_monitoring():
    logging.info("Running performance monitoring...")
    monitor_postgres(**PG_CONFIG)
    monitor_mysql(**MYSQL_CONFIG)

def run_query_optimization():
    sample_query = """
    SELECT * FROM users u
    JOIN orders o ON u.id = o.user_id
    WHERE u.name LIKE '%John%'
    """
    logging.info("Running query optimization...")
    optimize_query(sample_query)

def main():
    # Schedule tasks
    schedule.every().day.at("01:00").do(run_backups)
    schedule.every(30).minutes.do(run_performance_monitoring)
    schedule.every().hour.do(run_query_optimization)

    logging.info("Database management tasks scheduled. Running...")

    # Run the scheduled tasks
    while True:
        schedule.run_pending()
        time.sleep(60)

if __name__ == "__main__":
    main()