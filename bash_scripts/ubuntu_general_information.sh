#!/bin/bash

# Retrieve OS details
os_name=$(lsb_release -ds)
kernel_version=$(uname -r)

# Retrieve RAM details
ram_total=$(free -m | awk '/^Mem:/ {print $2}')

# Retrieve CPU details
cpu_model=$(cat /proc/cpuinfo | awk -F': ' '/^model name/ {print $2}' | head -n 1)
cpu_cores=$(nproc)

# Retrieve storage details
storage_total=$(df -h --total)

# Retrieve list of users
users=$(cut -d: -f1 /etc/passwd)

# Retrieve network ports
network_ports=$(netstat -tuln | awk '/^tcp|^udp/ {print $4}')

# Print system details
echo "Operating System: $os_name"
echo "Kernel Version: $kernel_version"
echo "RAM Total: $ram_total MB"
echo "CPU Model: $cpu_model"
echo "CPU Cores: $cpu_cores"
echo "Storage Total: $storage_total"
echo ""
echo "Users on the system:"
echo "$users"
echo ""
echo "Network Ports:"
echo "$network_ports"
