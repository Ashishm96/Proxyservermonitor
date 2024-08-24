#!/bin/bash

# Get Memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo $MEMORY_USAGE
