#! /bin/bash

cpu_row=$(top -bn1 | grep "%Cpu(s):")
TOTAL_CPU_USAGE=$(echo "$cpu_row" | awk '{print $2 + $4}')
echo "1. Total CPU Usage is (including both system and user processes): $TOTAL_CPU_USAGE %"



memory_row=$(top -bn1 | grep "MiB Mem :")
TOTAL_MEMORY=$(echo "$memory_row" | awk '{print $4}')
TOTAL_MEMORY_USED=$(echo "$memory_row" | awk '{print ($8 / $4)*100}')
TOTAL_MEMORY_FREE=$(echo "$memory_row" | awk '{print ($6 / $4)*100}')
echo "2. Total Memory used and free: $TOTAL_MEMORY_USED% , $TOTAL_MEMORY_FREE%"



disk_row=$(df -h /)
FileSystem_Name=$(echo "$disk_row" | awk 'NR>1 {print $1}')
DISK_USED=$(echo "$disk_row" | awk 'NR>1 {print $5}')
DISK_FREE=$(echo "$disk_row" | awk 'NR>1 {print 100 - $5}')
echo "3. Total Disk used and free for $FileSystem_Name: $DISK_USED , $DISK_FREE%"


TOP_5_CPU=$(ps aux --sort=-pcpu | head -n 6)
TOP_5_MEM=$(ps aux --sort=-pmem | head -n 6)

echo "4. Top 5 processes by CPU: $TOP_5_CPU"
echo "5. Top 5 processes by Memory: $TOP_5_Memory"