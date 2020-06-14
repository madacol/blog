[//]: # "Ctrl+K,V o Ctrl+Shift+V - Para ver vista previa en VSCode"

Tutorial to fast install [youtube-dl](https://github.com/ytdl-org/youtube-dl/) in android and configure it to download any url shared to it.

*Based on https://www.reddit.com/r/Piracy/comments/baufql/youtubedl_the_easy_way_on_android/*

1. [Install and configure youtube-dl](#Install-and-configure-youtube-dl)
2. [Extras](#Extras)
3. [All-In-One](#All-In-One)

# Install Termux
https://termux.com/

# Open Termux and run one of these:

## Install and configure youtube-dl

```bash
    # Ask for storage permission
    termux-setup-storage &&
    # Install youtube-dl
    apt update && apt upgrade && apt install python ffmpeg dialog && pip install youtube-dl &&
    # Configure to download videos in `Downloads/{URL's provider (e.g. Youtube)}/{filename}`
    mkdir -p ~/.config/youtube-dl &&
    echo "# Default Output Directory and Pattern
    -o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(title).150s-%(id)s.%(ext)s" > ~/.config/youtube-dl/config &&
    # Configure to open shared URLs with `youtube-dl {url}`
    mkdir ~/bin &&
    echo '#!/bin/bash
        URL=$1
        HEIGHT=15
        WIDTH=40
        CHOICE_HEIGHT=4

        CHOICE=$(dialog \
            --menu "Que desea descargar?" \
            $HEIGHT $WIDTH $CHOICE_HEIGHT \
            Video "" \
            Audio "" \
            2>&1 >/dev/tty)

        case $CHOICE in
            Video)
                youtube-dl $URL
                ;;
            Audio)
                youtube-dl -x $URL
                ;;
        esac' > ~/bin/termux-url-opener &&
    chmod +x ~/bin/termux-url-opener
```

## Extras

```bash
    # Add special keys to keyboard
    # source: https://wiki.termux.com/wiki/Touch_Keyboard#Extra_Keys_Row(s)
    mkdir ~/.termux
    echo "extra-keys = [ \
        ['ESC', '/', '|', 'HOME', 'UP', 'END', 'PGUP', '-'], \
        ['TAB','CTRL', 'ALT', 'LEFT', 'DOWN', 'RIGHT', 'PGDN', '~'] \
    ]" > ~/.termux/termux.properties
    # Install nano
    apt install nano
```

## All-In-One

youtube-dl + extras

```bash
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
```
