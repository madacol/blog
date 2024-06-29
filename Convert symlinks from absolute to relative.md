---
title: Convert symlinks from absolute to relative
tags: english, tutorial, til, linux, shell, symlink
date: 2023-07-17
---

## Install symlinks

```bash
sudo apt install symlinks
```

## Usage

```bash
symlinks -cr /path/to/folder
```

---

## `symlinks` help

```bash
$ symlinks -h
symlinks: scan/change symbolic links - v1.3 - by Mark Lord

Usage:	symlinks [-cdorstv] dirlist

Flags:	-c == change absolute/messy links to relative
        -d == delete dangling links
        -o == warn about links across file systems
        -r == recurse into subdirs
        -s == shorten lengthy links (displayed in output only when -c not specified)
        -t == show what would be done by -c
        -v == verbose (show all symlinks)
``````
