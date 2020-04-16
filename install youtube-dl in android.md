[//]: # "Ctrl+K,V o Ctrl+Shift+V - Para ver vista previa en VSCode"

Tutorial to fast install [youtube-dl](https://github.com/ytdl-org/youtube-dl/) in android and configure it to download any url shared to it. Based on https://www.reddit.com/r/Piracy/comments/baufql/youtubedl_the_easy_way_on_android/

# Quick Install

## Install Termux
https://termux.com/

## Open Termux and run this:

### Install youtube-dl

    termux-setup-storage &&
    apt update && apt upgrade && apt install python ffmpeg && pip install youtube-dl &&
    mkdir -p ~/.config/youtube-dl &&
    echo "# Default Output Directory and Pattern
    -o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(uploader)s/%(title)s-%(id)s.%(ext)s" > ~/.config/youtube-dl/config &&
    mkdir ~/bin &&
    echo "#!/bin/bash
    url=$1
    youtube-dl $url" > ~/bin/termux-url-opener &&
    chmod +x ~/bin/termux-url-opener

### Extras (install nano, and add special keys to keyboard)
    mkdir ~/.termux
    echo "extra-keys = [ \
        ['ESC', '/', '|', 'HOME', 'UP', 'END', 'PGUP', '-'], \
        ['TAB','CTRL', 'ALT', 'LEFT', 'DOWN', 'RIGHT', 'PGDN', '~'] \
    ]" > ~/.termux/termux.properties
    apt install nano

### All-In-One (youtube-dl + extras)
    termux-setup-storage &&
    apt update && apt upgrade && apt install nano python ffmpeg && pip install youtube-dl &&
    mkdir -p ~/.config/youtube-dl &&
    echo "# Default Output Directory and Pattern
    -o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(uploader)s/%(title)s-%(id)s.%(ext)s" > ~/.config/youtube-dl/config &&
    mkdir ~/bin &&
    echo "#!/bin/bash
    url=$1
    youtube-dl $url" > ~/bin/termux-url-opener &&
    chmod +x ~/bin/termux-url-opener &&
    mkdir ~/.termux &&
    echo "extra-keys = [ \
        ['ESC', '/', '|', 'HOME', 'UP', 'END', 'PGUP', '-'], \
        ['TAB','CTRL', 'ALT', 'LEFT', 'DOWN', 'RIGHT', 'PGDN', '~'] \
    ]" > ~/.termux/termux.properties