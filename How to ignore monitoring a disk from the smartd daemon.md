---
tags: english, tutorial
date: 2018-03-22
---

# How to ignore monitoring a disk from the smartd daemon

Source: <https://unix.stackexchange.com/a/111407/77354>

`-d ignore` is a new directive which allows ignoring a device from DEVICESCAN.

## To ignore disk `/dev/sdb`

```bash
sudo nano /etc/smartd.conf
```

add `/dev/sdb -d ignore` before the line that starts with `DEVICESCAN ...`

It should look something like this:

```
...
/dev/sdb -d ignore
DEVICESCAN -d removable -n standby -m root -M exec /usr/share/smartmontools/smartd-runner
...
```

## A better alternative: `-M diminishing`

> *diminishing* - send additional warning reminder emails, after a one-day interval, then a two-day interval, then a four-day interval, and so on for each type of disk problem detected. Each interval is twice as long as the previous interval.

Add `-M diminishing` to the line that starts with `DEVICESCAN ...`

```
...
DEVICESCAN -d removable -n standby -m root -M exec /usr/share/smartmontools/smartd-runner -M diminishing
...
```
