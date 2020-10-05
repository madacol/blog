# Ubuntu install guide

## Update & Upgrade

```bash
sudo apt update && sudo apt upgrade -y
```

## Install Packages

```bash
sudo apt-get install python3-pip zsh curl wget git
sudo apt-get install p7zip-full smplayer cmus speedtest-cli git-gui filezilla pavucontrol ufw servefile nmap fail2ban gimp most colordiff mosh dconf-editor ncdu qcalc jq tor fonts-noto &

pip3 install youtube-dl tldr
```

## External Repositories

### Antimicro

```bash
sudo add-apt-repository ppa:mdeguzis/libregeek
```

As of today, a bionic package is still not available, but the artful works!. <https://github.com/AntiMicro/antimicro/issues>

`sudo nano /etc/apt/sources.list.d/mdeguzis-ubuntu-libregeek-bionic.list` Replace `bionic` with `artful`

```bash
sudo apt update
sudo apt install antimicro
```

Put config file <https://gist.github.com/madacol/19f8c71ba98f484a4294ccfe90e88e6e> in `~/.config/antimicro`

### SinkSwitcher

<https://github.com/madacol/sinkSwitcher>

## Web installs

- docker: <https://download.docker.com>
- VSCode: <https://code.visualstudio.com/>
- chrome: <https://www.chrome.com/>
- syncthing: <https://apt.syncthing.net/>
- Zsh-syntax-highlighting: <https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md>

## Edit ~/.zshrc

### Add shortcut "Alt+:" [to iterate through arguments](https://stackoverflow.com/questions/4009412/how-to-use-arguments-from-previous-command/55069846#55069846)

```bash
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[:" copy-earlier-word
```

### Aliases

```bash
alias lr="ls -hartl"
alias youtube-dl720='youtube-dl -f "bestvideo[height<=720]+bestaudio/best[height<=720]"'
alias python=python3
alias ipython=ipython3
function mkcd () { mkdir -p "$@" && cd "$@"; }
```

### Enable most

```bash
export PAGER=most
```

### Enable zsh plugins

```bash
plugins=(git zsh-syntax-highlighting)
plugins=(autoswitch_virtualenv $plugins)
```
**Note:** Probably need to install them first

## Gnome extensions

- Caffeine <https://extensions.gnome.org/extension/517/caffeine/>
- ~~Dash to dock <https://extensions.gnome.org/extension/307/dash-to-dock/> `sudo apt remove gnome-shell-extension-ubuntu-dock` <https://github.com/micheleg/dash-to-dock/issues/643>~~
- NetSpeed <https://extensions.gnome.org/extension/104/netspeed/>

## Custom shortcuts

- `systemctl suspend`
- Cmus <https://medium.com/@madacol/configure-cmus-music-player-on-the-terminal-in-ubuntu-3c513d2d2cd0>

## StartUp

- Cmus `gnome-terminal -- cmus`
