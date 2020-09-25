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
5. Download file from any device `ipfs get /ipfs/QmdsEVLRXioANssEVLRXYioANsGtANsGtRXYioANsGtAWZ` <-- that's the hash returned from previous command
```bash
$ ls
QmdsEVLRXioANssEVLRXYioANsGtANsGtRXYioANsGtAWZ
```
Note the filename is just the hash, the original filename is lost.

*Haven't researched if there's an easy way to persist the filename*


## What led to learning this

- [Random news of ipfs in HN](https://blog.ipfs.io/2020-09-24-go-ipfs-0-7-0/). It just reminded me I've never tried it out.\
And in recent months I've had difficulty sharing files p2p
