---
tags: tutorial, tor, ssh, nat, firewall, english
date: 2020-07-16
---

# Configure an onion service

*Shamelessly copied from <https://www.techrepublic.com/article/how-to-run-an-ssh-connection-through-tor/>*

---

## Install Tor

Install Tor on both client and server:

    sudo apt-get install tor -y

## Configure Tor

1. In the server let's edit tor's config file `/etc/tor/torrc`:

        sudo nano /etc/tor/torrc

2. At the bottom of that file, add this:

        HiddenServiceDir /var/lib/tor/ssh/
        HiddenServicePort 22

    Optional extra configurations (trade-off anonimity for better performance)

        SocksPort 0
        HiddenServiceNonAnonymousMode 1
        HiddenServiceSingleHopMode 1

    <kbd>Ctrl</kbd>+<kbd>x</kbd> to save and close file.

3. Restart Tor:

        sudo systemctl restart tor

## Get .onion address

It will be in the file `hostname` in the previously configured folder `/var/lib/tor/ssh`

    sudo cat /var/lib/tor/ssh/hostname

You should get something like `riludi2kstjwmlzn.onion`

## Connect to the Tor hidden ssh server

    torify ssh ... # replace the domain/ip with the .onion address

For example:

    torify ssh jack@riludi2kstjwmlzn.onion

### Optional

You don't need to remember the **.onion** address, you can write an entry to your user's ssh config file `~/.ssh/config`:

    nano ~/.ssh/config

Set configuration:

    Host serverTor
        User jack
        HostName riludi2kstjwmlzn.onion
        Port 22

Now you can simply connect with:

    torify ssh serverTor

## More info

<https://community.torproject.org/onion-services/setup/>
