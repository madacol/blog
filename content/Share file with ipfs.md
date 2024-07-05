---
tags: tutorial, ipfs, file-sharing, nat, english
date: 2020-09-25
---

# Share file with ipfs

**Warning:** Only tested serving the file, not downloading it

1. [Install ipfs](https://ipfs.io/#install)
2. Initiate ipfs main folder `ipfs init`, not sure why but this is required for following commands
3. Serve a file `ipfs add {filepath}`. It should return something like this

    ```bash
    added QmdsEVLRXioANssEVLRXYioANsGtANsGtRXYioANsGtAWZ file.md
    37.62 KiB / 37.62 KiB [===========================] 100.00%
    ```

4. Start server with `ipfs daemon`
5. **Missing step**, server seems to need an open port (not firewalled)
6. Download file from any device `ipfs get /ipfs/QmdsEVLRXioANssEVLRXYioANsGtANsGtRXYioANsGtAWZ` <-- that's the hash returned from **step 3**

    ```bash
    $ ls
    QmdsEVLRXioANssEVLRXYioANsGtANsGtRXYioANsGtAWZ
    ```

Notice the filename is just the hash, the original filename is lost.

**Note:** *IPNS seems to solve the filename problem, need to research on how to use it*

## Troubleshoot

<https://github.com/ipfs/go-ipfs/blob/master/docs/file-transfer.md>

## What led to learning this

[Random news of ipfs in HN](https://blog.ipfs.io/2020-09-24-go-ipfs-0-7-0/). It just reminded me I've never tried it out.\
And in recent months I've had difficulty sharing files p2p
