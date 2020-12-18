# Ubuntu fresh setup guide

## Update & Upgrade

```bash
sudo apt update && sudo apt upgrade -y
```

## Install Packages

```bash
sudo apt-get install python3-pip zsh curl wget git
sudo apt-get install p7zip-full smplayer cmus speedtest-cli git-gui filezilla pavucontrol paprefs ufw servefile nmap fail2ban gimp most colordiff mosh dconf-editor ncdu qcalc jq tor fonts-noto nautilus-actions filemanager-actions thunderbird chrome-gnome-shell gnome-tweaks &

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

## Shells

### Fish

#### Functions

- nvm

  Install bass, then configure these functions

  - **__nvm_load.fish**

     ```fish
     function __nvm_load
       functions -e __nvm_load node npm npx
       bass source ~/.nvm/nvm.sh --no-use ';' nvm use 2> /dev/null '||' nvm use default
     end
     ```

  - **nvm.fish**

  ```fish
  function nvm
    functions -e __nvm_load node npm npx
    bass source ~/.nvm/nvm.sh --no-use ';' source ~/.nvm/bash_completion ';' nvm $argv
  end
  ```

  - **npx.fish**

  ```fish
  function npx
    __nvm_load
    npx $argv
  end
  ```

  - **npm.fish**

  ```fish
  function npm
    __nvm_load
    npm $argv
  end
  ```

  - **node.fish**

  ```fish
  function node
    __nvm_load
    node $argv
  end
  ```

### Zsh - Edit ~/.zshrc

#### Add `~/.local/bin` to PATH

```bash
export PATH=$HOME/.local/bin:$PATH
```

#### Add shortcut "Alt+:" [to iterate through arguments](https://stackoverflow.com/questions/4009412/how-to-use-arguments-from-previous-command/55069846#55069846)

```bash
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[:" copy-earlier-word
```

#### Aliases

```bash
alias lr="ls -hartl"
alias youtube-dl720='youtube-dl -f "bestvideo[height<=720]+bestaudio/best[height<=720]"'
alias python=python3
alias ipython=ipython3
function mkcd () { mkdir -p "$@" && cd "$@"; }
```

#### Lazy-load nvm

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . $NVM_DIR/nvm.sh --no-use;  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . $NVM_DIR/bash_completion;  # This loads nvm bash_completion
__nvm_load_node () {
  unalias node npm npx;
  nvm use 2> /dev/null || nvm use default;
}
alias node='__nvm_load_node; node $@'
alias npm='__nvm_load_node; npm $@'
alias npx='__nvm_load_node; npx $@'
```

#### Enable most

```bash
export PAGER=most
```

#### Enable zsh plugins

```bash
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
```

**Note:** Probably need to install them first

## Gnome extensions

- Caffeine <https://extensions.gnome.org/extension/517/caffeine/>
- NetSpeed <https://extensions.gnome.org/extension/104/netspeed/>

## Dconf

- `org.gnome.shell.extensions.dash-to-dock` = **`cycle-windows`** # so scroll-wheel cycle through apps in the launcher

## Custom shortcuts

- `systemctl suspend`
- Cmus <https://medium.com/@madacol/configure-cmus-music-player-on-the-terminal-in-ubuntu-3c513d2d2cd0>

## StartUp

- Cmus `gnome-terminal -- cmus`
