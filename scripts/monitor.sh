#!/bin/bash

# Source configuration file
source ../config/proxy_config.conf

# Log file location
LOG_FILE="../logs/monitor.log"

# Timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Monitor CPU Usage
CPU_USAGE=$(./cpu_usage.sh)

# Monitor Memory Usage
MEMORY_USAGE=$(./memory_usage.sh)

# Monitor Network Traffic
NETWORK_TRAFFIC=$(./network_traffic.sh)

# Check if proxy server is running
if pgrep -x "$PROXY_SERVER" > /dev/null
then
    PROXY_STATUS="Proxy server is running"
else
    PROXY_STATUS="Proxy server is not running"
fi

# Write the results to the log file
echo "$TIMESTAMP - CPU: $CPU_USAGE%, Memory: $MEMORY_USAGE%, Network: $NETWORK_TRAFFIC, Status: $PROXY_STATUS" >> $LOG_FILE
