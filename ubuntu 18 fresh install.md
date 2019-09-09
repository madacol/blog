## Update & Upgrade
```bash
sudo apt update && sudo apt upgrade -y
```

## Install Packages
```bash
sudo apt-get install python-pip p7zip-full smplayer cmus speedtest-cli zsh curl wget git git-gui filezilla pavucontrol ufw servefile nmap

pip install youtube-dl tldr
```

## Web installs
- docker     # https://download.docker.com
- VSCode 	   # https://code.visualstudio.com/
- chrome 	   # https://www.chrome.com/
- syncthing  # https://apt.syncthing.net/

## Edit ~/.zshrc
### Change history-size
```bash
HISTSIZE=10000
HISTFILESIZE=20000
```
### Add shortcut "Alt+:" [to iterate through arguments](https://stackoverflow.com/questions/4009412/how-to-use-arguments-from-previous-command/55069846#55069846)
```bash
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[:" copy-earlier-word
```

### Enable most
```bash
export PAGER=most
```

## Gnome extensions
- Caffeine
- Dash to dock https://extensions.gnome.org/extension/307/dash-to-dock/ `sudo apt remove gnome-shell-extension-ubuntu-doc` https://github.com/micheleg/dash-to-dock/issues/643
- suspend button NetSpeed https://extensions.gnome.org/extension/104/netspeed/
- NetSpeed https://extensions.gnome.org/extension/104/netspeed/

## Custom shortcuts
- `systemctl suspend`
- Cmus https://medium.com/@madacol/configure-cmus-music-player-on-the-terminal-in-ubuntu-3c513d2d2cd0

## StartUp
- Cmus `gnome-terminal -- cmus`