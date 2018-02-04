#!/bin/bash
PS4='$LINENO: '

apt-get -qq update && apt-get -qq --yes --force-yes install geoip-bin
echo "Installing GeoIP"
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -O /usr/share/GeoIP/GeoLiteCity.dat.gz
gzip -d /usr/share/GeoIP/GeoLiteCity.dat.gz
echo "Moving files to Document Root"
find_d=$(grep -n -e "DocumentRoot" /etc/apache2/sites-available/default-ssl.conf)
d_root=$(echo $find_d | cut -d " " -f 3)
mv trace.sh $rootfolder/trace.sh
mv index.php $rootfolder/index.php
echo "Finished!"
