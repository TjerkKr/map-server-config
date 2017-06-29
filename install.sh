#!/bin/bash

### This script assumes that you have an up to date debian etch with a working bat0 interface.

### SYSTEM (debian etch) ###

apt update
apt install git nginx nodejs npm ruby-sass prometheus grafana

###Install newer grafana / prometheus

mkdir /opt/prometheus/
cd /opt/prometheus/

wget https://ftp.de.debian.org/debian/pool/main/j/jquery/libjs-jquery_3.1.1-2_all.deb
wget https://ftp.de.debian.org/debian/pool/main/n/node-moment/libjs-moment_2.17.1+ds-1_all.deb
wget http://ftp.de.debian.org/debian/pool/main/e/eonasdan-bootstrap-datetimepicker/libjs-eonasdan-bootstrap-datetimepicker_4.17.43-1_all.deb
wget https://ftp.de.debian.org/debian/pool/main/p/prometheus/prometheus_1.6.2+ds-1_amd64.deb
wget https://ftp.de.debian.org/debian/pool/main/p/prometheus-node-exporter/prometheus-node-exporter_0.13.0+ds-1+b2_amd64.deb
sudo dpkg -i *
cd -

mkdir /opt/grafana
cd /opt/grafana/
wget https://s3-us-west-2.amazonaws.com/grafana-releases/master/grafana_4.4.0-7958pre1_amd64.deb
sudo dpkg -i *
cd -

### HOPGLASS-SERVER 

wget https://raw.githubusercontent.com/hopglass/hopglass-server/master/scripts/bootstrap.sh; bash bootstrap.sh; rm bootstrap.sh
# this step assumes that you have a bat0 interface. Otherwise change the config.json accordingly (e.g. to "br0")
cp ./hopglass-server/*.json /etc/hopglass-server/default/
systemctl start hopglass-server@default
systemctl enable hopglass-server@default

### HOPGLASS

pushd /opt/hopglass
git clone https://github.com/plumpudding/hopglass
cd hopglass
npm install
npm install grunt-cli
node_modules/.bin/grunt
popd
cp ./hopglass/config.json /opt/hopglass/hopglass/build/

#### GRAFANA & PROMETHEUS ####

cp ./grafana/grafana.ini /etc/grafana/
systemctl enable grafana-server
systemctl start grafana-server

cp ./prometheus/prometheus /etc/default/
cp ./prometheus/prometheus.yml /etc/prometheus/
systemctl enable prometheus
systemctl start prometheus

# you need an ip6 "::1" localhost entry in /etc/hosts as /hopglass is not listening on v4
cp ./nginx/default /etc/nginx/sites-available/
cp ./nginx/karte.freifunk-flensburg.de.conf /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/karte.freifunk-flensburg.de.conf /etc/nginx/sites-enabled/karte.freifunk-flensburg.de.conf
systemctl reload nginx

# now add http://localhost:9090/ as default prometheus datasource in the grafana webinterface under http://<host>/grafana
# add the grafana dashboards in the grafana/ folder of this project
