#!/bin/bash
PS4='$LINENO: '
declare -a ip_list
readarray ip_list < ip_list.txt
((ip_i = ${#ip_list[@]}))
((count = 0))
while(("${count}" < "${ip_i}")); do
	 ip=$(echo "${ip_list[count]}" | cut -f 1)
	uri=$(echo "${ip_list[count]}" | cut -f 2)
   req_time=$(echo "${ip_list[count]}" | cut -f 3)
   mystring=$(geoiplookup -f /usr/share/GeoIP/GeoLiteCity.dat "$ip")
      nonum=$(echo $mystring | sed 's/[0-9]*//g')
      mynum=${nonum:26}
      mynum="${mynum//./}"  #removes periods
      mynum="${mynum//,/}"  #removes commas
      mynum="${mynum//-/}"  #removes dashes
      mynum="${mynum////}"  #removes forward slashes
      mynum="${mynum//NA/}" #removes NA
      mynum=$(echo $mynum | xargs)
	uri=$(echo $uri | base64 --decode)
finalstring="${req_time} ${ip} ${mynum} ${uri}"
	echo $finalstring
	((count++))
done
