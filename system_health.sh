#!/bin/bash

CPU=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
MEMORY=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "CPU Usage: $CPU%"
echo "Free Memory Pages: $MEMORY"
echo "Disk Usage: $DISK%"

if [ "$DISK" -gt 80 ]; then
    echo "ALERT: Disk usage is above 80%"
fi