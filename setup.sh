#!/bin/bash
PS4='$LINENO: '
    install_php=$(dpkg -s php | grep "Status:" | cut -d " " -f 4)
  install_geoip=$(dpkg -s geoip-bin | grep "Status:" | cut -d " " -f 4)
install_apache2=$(dpkg -s apache2 | grep "Status:" | cut -d " " -f 4)
if [[ "$install_geoip" = "installed"]]; then
	echo "geoip-bin is installed"
else
	apt-get -qq update && apt-get -qq --yes --force-yes install geoip-bin
	echo "geoip-bin is installed"
fi

if [[ "$install_apache2" = "installed" ]]; then
	echo "apache2 is installed"
else
	apt-get -qq update && apt-get -qq --yes --force-yes install apache2
	echo "apache2 is installed"
fi

if [[ "$install_php" = "installed"]]; then
	echo "php is installed"
else
	apt-get --qq update && apt-get -qq --yes --force-yes install php
	echo "php is installed"
fi
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz -O /usr/share/GeoIP/GeoLiteCity.dat.gz
gzip -d /usr/share/GeoIP/GeoLiteCity.dat.gz
echo "Moving files to Document Root"
find_d=$(grep -n -e "DocumentRoot" /etc/apache2/sites-available/default-ssl.conf)
d_root=$(echo $find_d | cut -d " " -f 3)
mv trace.sh $rootfolder/trace.sh
mv index.php $rootfolder/index.php
echo "Finished!"
