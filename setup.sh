#!/bin/bash
PS4='$LINENO: '
apt-get -qq update
if ! [ -x "$(command -v php)"  ]; then
        apt-get -qq --yes --force-yes install php
else
        echo "PHP is installed"
fi

if ! [ -x "$(command -v apache2)" ]; then
        apt-get -qq --yes --force-yes install apache2
else
        echo "apache2 is installed"
fi

if ! [ -x "$(command -v geoip-bin)" ]; then
        apt-get -qq --yes --force-yes install geoip-bin
else
        echo "geoip-bin is installed"
fi

wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -O GeoLiteCity.dat.$
gzip -d GeoLiteCity.dat.gz
mv GeoLiteCity.dat /usr/share/GeoIP/GeoLiteCity.dat
echo "Moving files to Document Root"
find_d=$(grep -n -e "DocumentRoot" /etc/apache2/sites-available/default-ssl.conf)
d_root=$(echo $find_d | cut -d " " -f 3)
mv trace.sh "$d_root"/trace.sh
mv index.php "$d_root"/index.php
touch "$d_root"/../ip_list.txt
chmod 777 "$d_root"/../ip_list.txt
echo "Finished!"
