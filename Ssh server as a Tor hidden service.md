*Shamelessly copied from https://www.techrepublic.com/article/how-to-run-an-ssh-connection-through-tor/*

---

# Install Tor

Install Tor on both client and server:

    sudo apt-get install tor -y

# Configure Tor

In the ssh's server let's edit tor's config file `/etc/tor/torrc`:

    sudo nano /etc/tor/torrc

At the bottom of that file, add this:

    HiddenServiceDir /var/lib/tor/ssh/
    HiddenServicePort 22

Save and close file.

Restart Tor:

    sudo systemctl restart tor

And that's basically it!!!

After restarting Tor, it will generate all the necessary files within `/var/lib/tor/ssh`, there you'll find the hostname (.onion address) you need to connect to the server.

To find out that hostname:

    sudo cat /var/lib/tor/ssh/hostname

You should get something like `riludi2kstjwmlzn.onion`

# Connect to the Tor hidden ssh server

    torify ssh ...

For example:

    torify ssh jack@riludi2kstjwmlzn.onion

You can even make a config entry in `~/.ssh/config`, like this:

```
Host serverTor
    User jack
    HostName riludi2kstjwmlzn.onion
    Port 22
```

Now you can simply connect with:

    torify ssh serverTor