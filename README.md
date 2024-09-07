# Proxy Server Monitoring Project

## Overview

This project provides a set of Bash scripts designed to monitor a proxy server's system resources, such as CPU usage, memory usage, disk usage, and network traffic. The scripts offer a real-time dashboard format for displaying system metrics and allow users to filter specific data using command-line switches. Additionally, the project includes functionality for logging the status of the proxy server and performing automated security audits to identify and mitigate vulnerabilities. The entire setup is executed on AWS EC2 instances, making it scalable and adaptable for cloud environments. This project is open for collaboration on GitHub, encouraging contributions from the open-source community.

## Usage

1. Clone the repository.
2. Set up your configuration in `config/proxy_config.conf`.
3. Run the monitoring script: `./scripts/monitor.sh`.
4. Schedule the script using cron for continuous monitoring.

## Project Structure

```
ProxyServerMonitor/
├── scripts/
│   ├── monitor.sh          # Main script to monitor the proxy server
│   ├── cpu_usage.sh        # Script to monitor CPU usage
│   ├── memory_usage.sh     # Script to monitor memory usage
│   ├── network_traffic.sh  # Script to monitor network traffic
├── logs/
│   └── monitor.log         # Log file to store monitoring results
├── config/
│   └── proxy_config.conf   # Configuration file for the proxy server
├── README.md               # Project documentation
├── LICENSE                 # License file
└── .github/
    └── workflows/
        └── ci.yml          # Continuous Integration workflow
```

## Requirements

- **Bash Shell**: For running the scripts.
- **Git**: For version control and managing the repository.
- **cron**: For scheduling scripts (optional).
- **Proxy Server**: Such as Nginx, which you want to monitor.

## Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/YourUsername/ProxyServerMonitor.git
   cd ProxyServerMonitor
   ```

2. **Configure the Proxy Server**

   Edit `config/proxy_config.conf` with your proxy server details:

   ```conf
   # Proxy server settings
   PROXY_SERVER=nginx
   LOG_FILE="../logs/monitor.log"
   ```

   Change `PROXY_SERVER` if using a different server.

3. **Install Dependencies**

   Ensure you have necessary tools installed:

   ```bash
   sudo apt-get install ifconfig
   ```

## Script Details

### a. `scripts/monitor.sh`

The main script to coordinate the monitoring process:

```bash
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
```

### b. `scripts/cpu_usage.sh`

Monitors CPU usage:

```bash
#!/bin/bash

# Get CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo $CPU_USAGE
```

### c. `scripts/memory_usage.sh`

Monitors memory usage:

```bash
#!/bin/bash

# Get Memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo $MEMORY_USAGE
```

### d. `scripts/network_traffic.sh`

Monitors network traffic:

```bash
#!/bin/bash

# Get Network traffic (in and out)
NETWORK_IN=$(ifconfig eth0 | grep "RX packets" | awk '{print $5}')
NETWORK_OUT=$(ifconfig eth0 | grep "TX packets" | awk '{print $5}')
echo "In: $NETWORK_IN bytes, Out: $NETWORK_OUT bytes"
```

## Logging

Monitoring data is recorded in `logs/monitor.log`. This file contains timestamps and the recorded metrics.

## Scheduling the Monitoring Script

To run the monitoring script at regular intervals:

1. Open the cron tab:
   ```bash
   crontab -e
   ```

2. Add a cron job to run every 5 minutes:
   ```bash
   */5 * * * * /path/to/your/project/ProxyServerMonitor/scripts/monitor.sh
   ```

## Licensing

The project is licensed under the MIT License. See the `LICENSE` file for details:

```plaintext
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Continuous Integration (CI)

The project uses GitHub Actions for continuous integration. The workflow is defined in `.github/workflows/ci.yml`:

```yaml
name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Run Monitor Script
      run: ./scripts/monitor.sh
```

## Contributing

We welcome contributions! Please fork this repository and submit a pull request with any improvements or bug fixes.

## Contact  

For any questions or issues, please contact [Ashish Makasare](mailto:ashishmakasare24@gmail.com).

---
