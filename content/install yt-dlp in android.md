---
tags: tutorial, android, ssh, yt-dlp, termux, download, english
date: 2023-07-16
---

# Install yt-dlp in Android

*This tutorial was originally written for the famous [youtube-dl](https://github.com/ytdl-org/youtube-dl/) (R.I.P) and later adapted to its successor [yt-dlp](https://github.com/yt-dlp/yt-dlp), the adaptation hasn't been well tested*

---

Based on <https://www.reddit.com/r/Piracy/comments/baufql/youtubedl_the_easy_way_on_android/>

## Usage

Click **Share**, select **Termux**, choose video or audio, and that's it!, it will be saved to `Downloads/{Provider}/` e.g `Downloads/Youtube/`

## Install Termux

<https://termux.com/>

## Open Termux and run one of these

<!-- no toc -->
1. [Yt-dlp + sharing + dialog **(Recommended)**](#yt-dlp--sharing--dialog-recommended)
2. [Yt-dlp + sharing](#yt-dlp--sharing)
3. [Yt-dlp](#yt-dlp)
4. [Termux extras](#termux-extras)
5. [All-In-One](#all-in-one)

### Yt-dlp + sharing + dialog **(Recommended)**

```bash
# Ask for storage permission
termux-setup-storage &&
# Install yt-dlp
apt update && apt upgrade -y && apt install -y python ffmpeg dialog && pip install yt-dlp &&
# Configure to download videos in `Download/{URL's provider (e.g. Youtube)}/{filename}`
mkdir -p ~/.config/yt-dlp &&
echo "# Default Output Directory and Pattern
-o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(title).150s-%(id)s.%(ext)s" > ~/.config/yt-dlp/config &&
# Configure to open shared URLs with `yt-dlp {url}`
mkdir -p ~/bin &&
echo '#!/bin/bash
    URL=$1
    HEIGHT=15
    WIDTH=40
    CHOICE_HEIGHT=4

    CHOICE=$(dialog \
        --menu "What would you like to download?" \
        $HEIGHT $WIDTH $CHOICE_HEIGHT \
        Video "" \
        Audio "" \
        2>&1 >/dev/tty)

    case $CHOICE in
        Video)
            echo "Downloading video from $URL"
            yt-dlp $URL
            ;;
        Audio)
            echo "Downloading audio from $URL"
            yt-dlp -x $URL
            ;;
    esac' > ~/bin/termux-url-opener &&
chmod +x ~/bin/termux-url-opener
```

- Paste the script above 🖢 in the Termux console and press <kbd>Enter</kbd>
- A prompt to enable storage will appear, press <kbd>y</kbd> then <kbd>Enter</kbd>
- That's all!, just wait for it to finish upgrading/installing

#### Usage

Share an URL to termux, a dialog will ask you to choose if download **video** or just **audio**

### Yt-dlp + sharing

#### Usage

Share URL to termux, this will automatically download the video.

But if you always want to download just audio, replace `yt-dlp $url` with `yt-dlp -x $url` in the script below 🖣

```bash
    # Ask for storage permission
    termux-setup-storage &&
    # Install yt-dlp
    apt update && apt upgrade -y && apt install -y python ffmpeg && pip install yt-dlp &&
    # Configure to download videos in `Download/{URL's provider (e.g. Youtube)}/{filename}`
    mkdir -p ~/.config/yt-dlp &&
    echo "# Default Output Directory and Pattern
    -o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(title).150s-%(id)s.%(ext)s" > ~/.config/yt-dlp/config &&
    # Configure to open shared URLs with `yt-dlp {url}`
    mkdir -p ~/bin &&
    echo "#!/bin/bash
    url=$1
    yt-dlp $url" > ~/bin/termux-url-opener &&
    chmod +x ~/bin/termux-url-opener
```

### Yt-dlp

This will only install yt-dlp in termux, sharing a URL to Termux will not work, you'll need to run the command manually from the terminal, e.g `yt-dlp https://youtu.be/blahblahblah`

```bash
    # Ask for storage permission
    termux-setup-storage &&
    # Install yt-dlp
    apt update && apt upgrade -y && apt install -y python ffmpeg && pip install yt-dlp
```

### Termux extras

```bash
    # Add special keys to keyboard
    # source: https://wiki.termux.com/wiki/Touch_Keyboard#Extra_Keys_Row(s)
    mkdir -p ~/.termux
    echo "extra-keys = [ \
        ['ESC', '/', '|', 'HOME', 'UP', 'END', 'PGUP', 'ENTER'], \
        ['TAB','CTRL', 'ALT', 'LEFT', 'DOWN', 'RIGHT', 'PGDN', '~'] \
    ]" > ~/.termux/termux.properties
    # Install nano
    apt install -y nano
```

### All-In-One

Yt-dlp + sharing + dialog + Termux extras

```bash
    termux-setup-storage &&
    apt update && apt upgrade -y && apt install -y nano python ffmpeg dialog && pip install yt-dlp &&
    mkdir -p ~/.config/yt-dlp &&
    echo "# Default Output Directory and Pattern
    -o /data/data/com.termux/files/home/storage/downloads/%(extractor_key)s/%(title).150s-%(id)s.%(ext)s" > ~/.config/yt-dlp/config &&
    mkdir -p ~/bin &&
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
                yt-dlp $URL
                ;;
            Audio)
                yt-dlp -x $URL
                ;;
        esac' > ~/bin/termux-url-opener &&
    chmod +x ~/bin/termux-url-opener &&
    mkdir -p ~/.termux &&
    echo "extra-keys = [ \
        ['ESC', '/', '|', 'HOME', 'UP', 'END', 'PGUP', 'ENTER'], \
        ['TAB','CTRL', 'ALT', 'LEFT', 'DOWN', 'RIGHT', 'PGDN', '~'] \
    ]" > ~/.termux/termux.properties
```
