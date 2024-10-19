---
tags: tutorial, ubuntu, ubuntu 20, install, setup, english
date: 2019-02-12
---

# Ubuntu fresh setup guide

## Update & Upgrade

```bash
sudo apt update && sudo apt upgrade -y
```

## Install Packages

```bash
sudo apt-get install python3-pip zsh curl wget git dconf-editor
sudo apt-get install p7zip-full smplayer speedtest-cli git-gui pavucontrol paprefs ufw nmap fail2ban gimp most colordiff ncdu qalculate-gtk jq tor fonts-noto thunderbird chrome-gnome-shell gnome-tweaks smartmontools &

pip install pipx
pipx install yt-dlp tldr llm pipenv
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

### llm - ??

config `llm`

```bash
llm install llm-claude-3
llm keys set claude # Insert Claude API key generated in https://console.anthropic.com/settings/keys
```

script: <https://gist.github.com/madacol/2e8e2f5e22b03bfe4f22fbe30dd9c978>

```bash
#!/bin/zsh

# This script needs to be sourced in a zsh shell instead of being executed
# To do so, set an alias in your shell:
#    alias '??'='source $HOME/.local/bin/nlsh.zsh'
# Then you can use the `??` command from any zsh shell like this:
#    ?? extract the content of ./file.zip in the current directory

echo "$@" \
| llm -s 'Your task is to output oneliner shell commands.
Always answer with a single line shell command, or a multiline using code blocks' \
| tee /dev/shm/nlsh_stdout

extracted_command=$(sed -n '/^[ \t]*```/,/^[ \t]*```/{//!p}' /dev/shm/nlsh_stdout)

# If the command is empty, get the last line of the output
if [ -z "$extracted_command" ]; then
    extracted_command=$(tail -n 1 /dev/shm/nlsh_stdout)
fi

print -rz $extracted_command

```

add alias `??` in `~/.zshrc`

```bash
alias ??='source $HOME/.local/bin/nlsh.zsh'
```

## Web installs

- docker: <https://download.docker.com>
- VSCode: <https://code.visualstudio.com/>
- chrome: <https://www.chrome.com/>
- syncthing: <https://apt.syncthing.net/>
- Zsh-syntax-highlighting: <https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md>
- Zsh-autosuggestions: <https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md>

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
alias youtube-dl=yt-dlp
alias youtube-dl720='yt-dlp -f "bestvideo[height<=720]+bestaudio/best[height<=720]"'
function mkcd () { mkdir -p "$@" && cd "$@"; }
```

#### Lazy-load nvm

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . $NVM_DIR/nvm.sh --no-use;
[ -s "$NVM_DIR/bash_completion" ] && . $NVM_DIR/bash_completion;
function __nvm_load_node () {
  unalias node npm npx;
  nvm use 2> /dev/null || nvm use default;
  command=$1;
  shift 1;
  $command $@;
}
alias node='__nvm_load_node node $@'
alias npm='__nvm_load_node npm $@'
alias npx='__nvm_load_node npx $@'
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
- EasyScreenCast <https://extensions.gnome.org/extension/690/easyscreencast/>

## Dconf

### Built-in dash-to-dock extension

- `org.gnome.shell.extensions.dash-to-dock.click-action` = **`cycle-windows`**
- `org.gnome.shell.extensions.dash-to-dock.scroll-action` = **`cycle-windows`**
- `org.gnome.shell.extensions.dash-to-dock.show-windows-preview` = **`false`**

## Custom shortcuts

- `systemctl suspend`
- [Cmus setup and shortcuts](./Cmus%20setup%20and%20shortcuts.md)
- `qalculate`

## StartUp

- Cmus `gnome-terminal -- cmus`

## Nautilus

Add context menu to convert to MP4 using ffmpeg

```bash
nano ~/.local/share/nautilus/scripts/Convert\ to\ MP4
```

```bash
#!/bin/bash
ffmpeg -i ${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS}\
        -y -vf "scale='bitand(oh*dar,65534)':'min(720,ih)'"\
        /dev/shm/video.mp4\
        2> /dev/shm/convertToMP4.log
```
