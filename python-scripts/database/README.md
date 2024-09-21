# Database Management Scripts

This directory contains Python scripts for managing and optimizing database operations, including backups, performance monitoring, and query optimization.

## Files

- `db_mysql_backup.py`: Creates MySQL database backups
- `db_postgresql_backup.py`: Creates PostgreSQL database backups
- `db_performance_monitor.py`: Monitors performance of MySQL and PostgreSQL databases
- `query_optimizer.py`: Analyzes and optimizes SQL queries
- `main.py`: Schedules and runs database management tasks

## MySQL Backup (`db_mysql_backup.py`)

Features:
- Uses `mysqldump` for backup creation
- Generates timestamped backup files
- Logs the backup process
- Handles potential errors

Setup:
1. Replace placeholder values with actual database credentials and backup path
2. Ensure `mysqldump` is available in the system PATH

## PostgreSQL Backup (`db_postgresql_backup.py`)

Features:
- Uses `pg_dump` for backup creation
- Generates timestamped backup files
- Logs the backup process
- Uses environment variable for password (more secure)

Setup:
1. Replace placeholder values with actual database credentials and backup path
2. Set the `PGPASSWORD` environment variable with the database password
3. Ensure `pg_dump` is available in the system PATH

## Database Performance Monitor (`db_performance_monitor.py`)

Features:
- Monitors both PostgreSQL and MySQL databases
- Checks for active connections and slow queries
- Logs performance metrics and warnings

Setup:
1. Replace placeholder values with actual database credentials
2. Install required libraries:
   ```
   pip install psycopg2-binary mysql-connector-python
   ```
3. Adjust the slow query threshold as needed

## Query Optimizer (`query_optimizer.py`)

Features:
- Analyzes query structure using `sqlparse`
- Suggests optimizations based on query complexity
- Performs basic query optimizations

Setup:
1. Install required library:
   ```
   pip install sqlparse
   ```
2. Adjust the sample query or integrate with your database management system

## Main Script (`main.py`)

Features:
- Schedules and runs database management tasks:
  - Daily backups at 1:00 AM
  - Performance monitoring every 30 minutes
  - Query optimization every hour

Setup:
1. Install required library:
   ```
   pip install schedule
   ```
2. Adjust database configurations and backup directories
3. Modify the sample query in `run_query_optimization()` or integrate with your queries

Usage:
```bash
python main.py
```

## Notes

- Ensure all scripts are in the same directory or adjust import statements accordingly
- Replace placeholder values with actual database credentials and paths
- These scripts provide basic functionality. Add error handling and logging as needed for production use
````

This README provides an overview of the scripts in the `database` directory, their features, setup instructions, and usage notes for users.
````
