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

## Wartung

Änderungen bitte per Diskussion im PR

## Issues

Zur Zeit müssen ggf. die MAC Adressen der Supernodes nach einer Änderung händisch in den hopglass-server eingepflegt werden. Dies funktioniert über die Datei [hopglass-server/alias.json](hopglass-server/alias.json)

Diskussion: https://github.com/freifunk-ffm/map-server-config/issues/2

Zukünftig könnten wir über die Verwendung von https://github.com/ffnord/ffnord-alfred-announce nachdenken, welches als respondd client auf den Supernodes läuft und diese damit "automatisch" über den hopglass-server auf die Karte bringt.


## Live

Zur Zeit ist diese map anzuschauen unter: https://karte.freifunk-flensburg.de/

## Anleitungen
https://libraries.io/github/hopglass/hopglass-server


#fastd 
fastd.conf muss nach /etc/fastd/_username_der_fastd_startet_/

secret in die fastd.conf eintragen

autostart mit systemd:

fastd@.service ---> /lib/systemd/system/fastd@.service

systemctl enable fastd@root.service

#batman compat14 version 2013.4 erzwingen
dkms remove batman-adv/2013.4.0 --all

dkms --force install batman-adv/2013.4.0

batman-adv ---> /etc/modules

