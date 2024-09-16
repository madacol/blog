---
tags: english, tutorial, til
date: 2018-03-22
---

# How to ignore monitoring a disk from the smartd daemon

Source: <https://unix.stackexchange.com/a/111407/77354>

`-d ignore` is a new directive which allows ignoring a device from DEVICESCAN.

If we want to ignore the disk `/dev/sdb`, edit `/etc/smartd.conf` and add `/dev/sdb -d ignore` before the line that starts with `DEVICESCAN`

It should look something like this:

```
...

# The word DEVICESCAN will cause any remaining lines in this
# configuration file to be ignored: it tells smartd to scan for all
# ATA and SCSI devices.  DEVICESCAN may be followed by any of the
# Directives listed below, which will be applied to all devices that
# are found.  Most users should comment out DEVICESCAN and explicitly
# list the devices that they wish to monitor.
/dev/sdb -d ignore
DEVICESCAN -d removable -n standby -m root -M exec /usr/share/smartmontools/smartd-runner

...
```

I needed to stop the warning email messages from the smartd daemon, *yeah I know my disk is failing so just shut up.*

Also found out about the interesting `-M diminishing` directive

> *diminishing* - send additional warning reminder emails, after a one-day interval, then a two-day interval, then a four-day interval, and so on for each type of disk problem detected. Each interval is twice as long as the previous interval.
