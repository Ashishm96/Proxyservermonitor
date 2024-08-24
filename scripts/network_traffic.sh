#!/bin/bash

# Get Network traffic (in and out)
NETWORK_IN=$(ifconfig eth0 | grep "RX packets" | awk '{print $5}')
NETWORK_OUT=$(ifconfig eth0 | grep "TX packets" | awk '{print $5}')
echo "In: $NETWORK_IN bytes, Out: $NETWORK_OUT bytes"
