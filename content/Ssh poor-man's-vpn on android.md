---
tags: tutorial, android, ssh, firefox, termux, proxy, english
date: 2020-10-18
---

# Ssh poor-man's-vpn on android

## TL;DR

 1. Install [Termux](https://termux.com/) app on android
 2. In termux install openssh `pkg i -y openssh`
 3. ssh into server using *dynamic port forwarding* `ssh user@server -D12345`
 4. Install [Firefox Beta](https://play.google.com/store/apps/details?id=org.mozilla.firefox_beta) on android (as of now, plain Firefox doesn't support configuring with `about:config`)
 5. Open Firefox Beta, and go to `about:config`
 6. Search `proxy`
 7. Look for and set the following properties:

    ```yaml
    network.proxy.allow_hijacking_localhost: true
    network.proxy.socks: localhost
    network.proxy.socks_port: 12345
    network.proxy.type: 1
    ```

    make sure `network.proxy.socks_port` matches with the port in the ssh command above

 8. Done!, you are now navigating through the ssh server on Firefox

---

## Full instructions using ssh-keys

### Usage

1. Open Termux and run `ssh user@server -D12345` (or just press <kbd>Up</kbd>+<kbd>Enter</kbd> if you have run this command previously)
2. Navigate using the proxy-configured Firefox
3. Done!, your traffic is going through the server

### Setup Android

#### Termux

1. Install [Termux](https://termux.com/)
2. Configure ssh client by running the following commands:

    ```bash
    # Ask for storage permission
    termux-setup-storage &&
    # Install openssh
    apt update && apt upgrade -y &&
    apt install -y openssh &&
    # Generate an SSH key
    ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa &&
    # Set a password for the private key
    # Get public key
    echo -e '\nCopy the following public key:' &&
    cat ~/.ssh/id_ecdsa.pub
    ```

3. (Optional) If you have access to the server with ssh, then run:

    ```bash
    ssh-copy-id user@server
    ```

    If not, you need to manually add the public key to the server. This is explained below in the **Setup server** section

#### Firefox

1. Install [Firefox Beta](https://play.google.com/store/apps/details?id=org.mozilla.firefox_beta) - normal firefox might work if you can access to `about:config`
2. Open Firefox and go to the url `about:config`, search `proxy` and set the following configurations:

    ```yaml
    network.proxy.allow_hijacking_localhost: true
    network.proxy.socks: localhost
    network.proxy.socks_port: 12345
    network.proxy.type: 1
    ```

    make sure `network.proxy.socks_port` matches with the port used in the ssh command in the **Usage** section

### Setup server

If you succesfully run the command `ssh-copy-id` there's nothing to do here.\
But if not, you need to manually add the public key generated:

```bash
echo 'public key' >> ~/.ssh/authorized_keys
```
