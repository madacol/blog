---
tags: tutorial, tor, ssh, nat, firewall, spanish
---

# Configurar a un servicio onion

*copiado sin verguenza alguna de <https://www.techrepublic.com/article/how-to-run-an-ssh-connection-through-tor/>*

---

## Instalar Tor

Instalar Tor en el cliente y en el servidor:

    sudo apt-get install tor -y

## Configurar Tor

1. En el servidor vamos a editar el archivo de configuración de tor `/etc/tor/torrc`:

        sudo nano /etc/tor/torrc

2. Al final del archivo vamos a agregar esto:

        HiddenServiceDir /var/lib/tor/ssh/
        HiddenServicePort 22

    Configuraciones extras opcionales (sacrificar anonimidad para mejorar rendimiento)

        SocksPort 0
        HiddenServiceNonAnonymousMode 1
        HiddenServiceSingleHopMode 1

    <kbd>Ctrl</kbd>+<kbd>x</kbd> para guardar y cerrar el archivo.

3. Reiniciar Tor:

        sudo systemctl restart tor

## Obtener la direccion .onion

Estará en el archivo `hostname` en la carpeta configurada anteriormente `/var/lib/tor/ssh/`

    sudo cat /var/lib/tor/ssh/hostname

Deberia arrojarte algo así: `riludi2kstjwmlzn.onion`

## Conectarse al servidor ssh con la direccion .onion

    torify ssh ... # reemplazar el dominio/ip por la direccion .onion`

Por ejemplo:

    torify ssh jack@riludi2kstjwmlzn.onion

### Opcional

Para no tener que recordar la direccion **.onion** puedes configurar los parámetros de conexión en el archivo `~/.ssh/config`

    nano ~/.ssh/config

Ingresar configuracion:

    Host serverTor
        User jack
        HostName riludi2kstjwmlzn.onion
        Port 22

Ahora puedes conectarte así:

    torify ssh serverTor

## Mas informacion

<https://community.torproject.org/onion-services/setup/>
