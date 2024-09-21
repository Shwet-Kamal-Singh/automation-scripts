import psycopg2
import mysql.connector
import logging
from datetime import datetime

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def monitor_postgres(host, port, user, password, dbname):
    try:
        conn = psycopg2.connect(host=host, port=port, user=user, password=password, dbname=dbname)
        cur = conn.cursor()
        
        # Query for active connections
        cur.execute("SELECT count(*) FROM pg_stat_activity WHERE state = 'active';")
        active_connections = cur.fetchone()[0]
        
        # Query for slow queries
        cur.execute("SELECT query, duration FROM pg_stat_activity WHERE state = 'active' AND duration > interval '5 seconds';")
        slow_queries = cur.fetchall()
        
        logging.info(f"PostgreSQL - Active connections: {active_connections}")
        for query, duration in slow_queries:
            logging.warning(f"Slow query ({duration}): {query[:100]}...")
        
        cur.close()
        conn.close()
    except Exception as e:
        logging.error(f"PostgreSQL monitoring error: {e}")

def monitor_mysql(host, port, user, password, database):
    try:
        conn = mysql.connector.connect(host=host, port=port, user=user, password=password, database=database)
        cursor = conn.cursor()
        
        # Query for active connections
        cursor.execute("SHOW STATUS LIKE 'Threads_connected';")
        active_connections = cursor.fetchone()[1]
        
        # Query for slow queries
        cursor.execute("SELECT * FROM information_schema.PROCESSLIST WHERE TIME > 5;")
        slow_queries = cursor.fetchall()
        
        logging.info(f"MySQL - Active connections: {active_connections}")
        for query in slow_queries:
            logging.warning(f"Slow query (ID: {query[0]}, Time: {query[5]}s): {query[7][:100]}...")
        
        cursor.close()
        conn.close()
    except Exception as e:
        logging.error(f"MySQL monitoring error: {e}")

if __name__ == "__main__":
    # PostgreSQL configuration
    PG_HOST = "localhost"
    PG_PORT = "5432"
    PG_USER = "your_pg_username"
    PG_PASSWORD = "your_pg_password"
    PG_DB = "your_pg_database"

    # MySQL configuration
    MY_HOST = "localhost"
    MY_PORT = "3306"
    MY_USER = "your_mysql_username"
    MY_PASSWORD = "your_mysql_password"
    MY_DB = "your_mysql_database"

    monitor_postgres(PG_HOST, PG_PORT, PG_USER, PG_PASSWORD, PG_DB)
    monitor_mysql(MY_HOST, MY_PORT, MY_USER, MY_PASSWORD, MY_DB)