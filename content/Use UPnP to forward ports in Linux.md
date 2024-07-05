---
tags: english, tutorial, til
date: 2022-11-06
---

# Use UPnP to forward ports in Linux

Install [MiniUPnP](https://miniupnp.tuxfamily.org/)

```bash
sudo apt install -y miniupnpc
```

Forward external port `2222` to `192.168.0.10` at port `22`

```bash
upnpc -a 192.168.0.10 22 2222 TCP
```

If you want to keep it open, you can run this in your crontab. `crontab -e`

    */30 * * * * /usr/bin/upnpc -e "SSH" -a $(hostname -I | cut -d\  -f1) 22 2222 TCP

or using a dedicated script

```bash
#!/usr/bin/env bash

IP=$(hostname -I | cut -d\  -f1)
upnpc -e "SSH" -a $IP 22 2222 TCP
```


---

If you have a firewall enabled like `ufw`, this error can appear `No IGD UPnP Device found on the network !`, you need to allow incoming UDP packets from the router

```bash
sudo ufw allow from 192.168.1.1 to any proto udp comment upnp
```