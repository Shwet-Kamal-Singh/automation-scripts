#!/bin/bash

# cache-clearing.sh
# This script clears various types of caches on a Linux system.

echo "Starting cache clearing process..."

# Clear PageCache, dentries, and inodes
echo "Clearing PageCache, dentries, and inodes..."
sync; echo 3 > /proc/sys/vm/drop_caches

# Clear systemd journal logs
echo "Clearing systemd journal logs..."
journalctl --vacuum-time=2weeks

# Clear apt cache
echo "Clearing apt cache..."
apt-get clean

# Clear thumbnail cache
echo "Clearing thumbnail cache..."
rm -rf ~/.cache/thumbnails/*

# Clear user cache
echo "Clearing user cache..."
rm -rf ~/.cache/*

echo "Cache clearing process completed."

# Optionally, you can add a cron job to run this script periodically
# (e.g., weekly) by adding the following line to your crontab:
# 0 0 * * 0 /path/to/cache-clearing.sh