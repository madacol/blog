---
title: Cmus setup and shortcuts
tags: english, tutorial
date: 2023-01-13
---

# Install

    sudo apt install cmus

# Add music to Library

Press `5` to see the filesystem and `a` to add any selected file or folder to the *Library* ( Views `1` and `2`)

# Shortcuts to setup

| Actions       | Command                  |
| ------------- | ------------------------ |
| Open          | `gnome-terminal -e cmus` |
| Play/Pause    | `cmus-remote --pause`    |
| Next song     | `cmus-remote --next`     |
| Previous song | `cmus-remote --prev`     |
| Stop          | `cmus-remote --stop`     |
| Rewind        | `cmus-remote --seek -5`  |
| Forward       | `cmus-remote --seek +5`  |


# Common key-bindings:

| Actions                                 | Key |
| --------------------------------------- | --- |
| Repeat                                  | `r` |
| Shuffle                                 | `s` |
| Follow                                  | `f` |
| Continue                                | `C` |
| toggle play mode [ all, artist, album ] | `m` |
| Repeat current                          | `^R` (<kbd>Ctrl</kbd>+<kbd>r</kbd>) |

| Views    | Key |
| -------- | --- |
| tree     | `1` |
| sorted   | `2` |
| playlist | `3` |
| queue    | `4` |
| browser  | `5` |
| filters  | `6` |
| settings | `7` |

# Search

    /{text} #/foo