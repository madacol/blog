---
tags: english, tutorial, til, linux, networks, packet, netcat, script
date: 2023-07-14
---

# Script to send WOL magic packet using netcat

WOL stands for Wake On Lan, and it's a feature that allows you to turn on a computer remotely by sending a magic packet to its network interface

## Install netcat

```bash
sudo apt install netcat
```

## Script

**wol.sh**

```bash
#!/bin/bash

# MAC address of the target machine
MAC=$1

# Convert MAC address into hex
HEX_MAC=$(echo $MAC | sed 's/://g')

# Create the magic packet
MAGIC_PACKET=$(printf 'f%.0s' {1..12}; printf "${HEX_MAC}%.0s" {1..16})

# Send the magic packet using netcat
echo -e $MAGIC_PACKET | xxd -r -p | nc -w1 -ub 255.255.255.255 $2
```

## Usage

```bash
./wol.sh <MAC address> <port>
```

Usually the port is 9 or 7

## Debugging

### Check if the magic packet is being sent

```bash
sudo nc -luk <port> | xxd
```