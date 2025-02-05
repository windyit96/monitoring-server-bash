#!/bin/bash

echo "================= Server Monitoring ================="
echo "Date: $(date)"
echo "------------------------------------------------------------"

# Total CPU Usage
echo "🔹 Total CPU Usage:"
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
echo "   Used: $CPU_USAGE"
echo "------------------------------------------------------------"

# Total Memory Usage
echo "🔹 Total Memory Usage:"
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_FREE=$(free -m | awk '/Mem:/ {print $4}')
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($MEM_USED/$MEM_TOTAL)*100}")
echo "   Total: ${MEM_TOTAL}MB"
echo "   Used: ${MEM_USED}MB (${MEM_PERCENT}%)"
echo "   Free: ${MEM_FREE}MB"
echo "------------------------------------------------------------"

# Total Disk Usage
echo "🔹 Total Disk Usage:"
DISK_TOTAL=$(df -h --total | grep 'total' | awk '{print $2}')
DISK_USED=$(df -h --total | grep 'total' | awk '{print $3}')
DISK_FREE=$(df -h --total | grep 'total' | awk '{print $4}')
DISK_PERCENT=$(df -h --total | grep 'total' | awk '{print $5}')
echo "   Total: ${DISK_TOTAL}"
echo "   Used: ${DISK_USED} (${DISK_PERCENT})"
echo "   Free: ${DISK_FREE}"
echo "------------------------------------------------------------"

# Top 5 Processes by CPU Usage
echo "🔹 Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "------------------------------------------------------------"

# Top 5 Processes by Memory Usage
echo "🔹 Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
echo "============================================================"
