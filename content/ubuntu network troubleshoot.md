---
tags: tutorial, ubuntu, ubuntu 18, ubuntu 20, network, troubleshoot, english
date: 2021-02-24
---

# Ubuntu Network Troubleshoot

# NetworkManager

- `nm-applet` to run old GUI and activate `Enable Networking`.

- `nm-connection-editor` to edit any weird configuration in the connections.

- You can also see what the **NetworkManager** is doing with these commands.
```bash
# Run one by one to see if anything is useful
nmcli device
nmcli
nmcli device show
```

`unmanaged` means **NetworkManager** will not manage that device.

### Documentation: https://help.ubuntu.com/community/NetworkManager

---

# Netplan

```bash
# Create a config file
sudo nano /etc/netplan/ethernet.yaml
```
and enter this
```bash
network:
  version: 2
  renderer: networkd
  ethernets:
    eno1:
      dhcp4: true
```
replace `eno1` with whatever your device is (mine was `ens33`).
To see your list of devices, run `ip addr`.

Finally apply the new configurations

    sudo netplan apply

### Documentation: https://netplan.io/reference#examples
