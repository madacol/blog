---
title: Configure ssh keys in Mikrotik
tags: tutorial, network, mikrotik, ssh, security, english
date: 2020-10-01
---

```mikrotik
# Create a dummy file
/file print file=dummyFile
# Set its content to the public key
/file set dummyFile.txt contents="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA7QEcjRkbBWpwE7zIShobue9aEGyVObVHDLhK"
# Assign public key to user
/user ssh-keys import public-key-file=dummyFile.txt user=admin
```

Change the *public key*, and *user* accordingly

## What led to learning this

After having troubles with a mikrotik router I had to reconfigure it from scratch (didn't have a backup :sad:), and in the process the router got hacked, which pushed me to improve security measures
