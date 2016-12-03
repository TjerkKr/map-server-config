# Server config files hopglass map-server mit Prometheus und Grafana

## Installation

Die Datei install.sh enthält eine Schritt für Schritt Anleitung nach welcher die hopglass-map installiert ist. Als Betriebssystem wird debian etch angenommen. Die Verwendeten Komponenten sind:

- Webserver (Nginx, weil gzip-Komprimierung und reverse proxies damit einfacher sind)
- eine aktuelle Version von NodeJS (Version >4.3) (https://nodejs.org/en/download/package-manager/)
- Hopglass Server (https://github.com/plumpudding/hopglass-server)
- Hopglass Viewer (https://github.com/plumpudding/hopglass)
- Prometheus (http://prometheus.io)
- Grafana (http://grafana.org)

Die angepassten configs finden sich in den jeweiligen Unterverzeichnissen.


## Issues

Zur Zeit müssen ggf. die MAC Adressen der Supernodes nach einer Änderung händisch in den hopglass-server eingepflegt werden. Dies funktioniert über die Datei [hopglass-server/alias.json](hopglass-server/alias.json)



## Live

Zur Zeit ist diese map anzuschauen unter: https://karte.freifunk-flensburg.de/

# zusätzliche Anleitungen

https://libraries.io/github/hopglass/hopglass-server


##fastd
user der fastd ausführt muss netzwerkschnittstellen erstellen können(zb root)

fastd.conf muss nach /etc/fastd/_username_der_fastd_startet_/

secret in die fastd.conf eintragen

In den "on up" Bereich für $INTERFACE und bat0 Mac-Adresse generieren und einfügen.



autostart mit systemd:

fastd@.service ---> /lib/systemd/system/fastd@.service

systemctl enable fastd@_username_der_fastd_startet_.service

##batman compat14 version 2013.4 erzwingen

echo "deb http://repo.universe-factory.net/debian/ sid main" >>/etc/apt/sources.list

apt-get install apt-transport-https

gpg --keyserver pgpkeys.mit.edu --recv-key  16EF3F64CB201D9C

gpg -a --export 16EF3F64CB201D9C | apt-key add -

apt-get update

modinfo batman-adv (Batman Version prüfen)

apt-get install batman-adv-dkms

dkms remove batman-adv/2013.4.0 --all

dkms --force install batman-adv/2013.4.0

modprobe batman-adv (falls falsche Version "rmmod batman-adv" und dann noch mal die beiden dkms befehle)

dmesg (Kontrolle ob geladen und welche Version)


batman-adv ---> /etc/modules

##webserver kopieren

/opt/hopglass/hopglass/build/* kopieren nach /var/www/html
