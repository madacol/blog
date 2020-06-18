[//]: # "Ctrl+K,V o Ctrl+Shift+V - Para ver vista previa en VSCode"

Tutorial to install [youtube-dl](https://github.com/ytdl-org/youtube-dl/) in android via [termux](https://termux.com/), and configure it to download links shared from another app.

*Based on https://www.reddit.com/r/Piracy/comments/baufql/youtubedl_the_easy_way_on_android/*

# Usage

Click **Share**, select **Termux**, choose video or audio, and that's it!, it will be saved to `Downloads/{Provider}/` e.g `Downloads/Youtube/`

# Install Termux
https://termux.com/

# Open Termux and run one of these:

1. [Youtube-dl + sharing + dialog **(Recommended)**](#youtube-dl--sharing--dialog-recommended)
2. [Youtube-dl + sharing](#youtube-dl--sharing)
3. [Youtube-dl](#youtube-dl)
4. [Termux extras](#termux-extras)
5. [All-In-One](#all-in-one)

## Youtube-dl + sharing + dialog **(Recommended)**

After sharing a URL to termux, a dialog will appear so you can choose to download video or just audio

```bash
    # Ask for storage permission
    termux-setup-storage &&
    # Install youtube-dl
    apt update && apt upgrade -y && apt install python ffmpeg dialog && pip install youtube-dl &&
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

## Youtube-dl + sharing

Afeter sharing URL to termux this will automatically download the video. But if you always want just audio, replace `youtube-dl $url` with `youtube-dl -x $url`

```bash
    # Ask for storage permission
    termux-setup-storage &&
    # Install youtube-dl
    apt update && apt upgrade -y && apt install python ffmpeg && pip install youtube-dl &&
    # Configure to download videos in `Downloads/{URL's provider (e.g. Youtube)}/{filename}`
    mkdir -p ~/.config/youtube-dl &&
    echo "# Default Output Directory and Pattern
    -o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(title).150s-%(id)s.%(ext)s" > ~/.config/youtube-dl/config &&
    # Configure to open shared URLs with `youtube-dl {url}`
    mkdir ~/bin &&
    echo "#!/bin/bash
    url=$1
    youtube-dl $url" > ~/bin/termux-url-opener &&
    chmod +x ~/bin/termux-url-opener
```

## Youtube-dl

This will only install youtube-dl in termux, sharing a URL to Termux will not work, you'll need to run the command manually from the terminal, e.g `youtube-dl https://youtu.be/blahblahblah`

```bash
    # Ask for storage permission
    termux-setup-storage &&
    # Install youtube-dl
    apt update && apt upgrade -y && apt install python ffmpeg && pip install youtube-dl
```


## Termux extras

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

Youtube-dl + sharing + dialog + Termux extras

```bash
    termux-setup-storage &&
    apt update && apt upgrade -y && apt install nano python ffmpeg && pip install youtube-dl &&
    mkdir -p ~/.config/youtube-dl &&
    echo "# Default Output Directory and Pattern
    -o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(title).150s-%(id)s.%(ext)s" > ~/.config/youtube-dl/config &&
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
    chmod +x ~/bin/termux-url-opener &&
    mkdir ~/.termux &&
    echo "extra-keys = [ \
        ['ESC', '/', '|', 'HOME', 'UP', 'END', 'PGUP', '-'], \
        ['TAB','CTRL', 'ALT', 'LEFT', 'DOWN', 'RIGHT', 'PGDN', '~'] \
    ]" > ~/.termux/termux.properties
```