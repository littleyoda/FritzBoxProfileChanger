#!/bin/bash
if [ $# != 5 ] 
then
  echo "profilechange.bash user pwd ip profilename [never|unlimited]"
  exit 1
fi
user=$1
pwd=$2
ip=$3
profil=$4
status=$5

echo "User:   ${user}"
echo "Pwd:    ${pwd}"
echo "IP:     ${ip}"
echo "Profil: ${profil}"
echo "Status: ${status}"

echo "=========================================================================="

challenge=$(curl -s "http://${ip}/login_sid.lua?username=${user}" | grep -Po '(?<=<Challenge>).*?(?=</Challenge>)')
echo "Challenge: ${challenge}"

md5=$(echo -n ${challenge}"-"${pwd} | iconv -f ISO8859-1 -t UTF-16LE | md5sum -b | awk '{print substr($0,1,32)}') 
response="${challenge}-${md5}"
echo "Response: $response"

sid=$(curl -i -s -k -d "response=${response}&username=${user}" "http://${ip}" | grep -Po -m 1 '(?<=sid\":\")[a-f\d]+' | tail -1)
if [ "${sid}" = "0000000000000000" ]
then
   echo "Fehler bei der Extraktion der SID"
   exit 1
fi
echo "SID: $sid"


a=`curl -s -d "sid=${sid}&edit=${profil}&time=${status}&budget=unlimited&apply=&page=kids_profileedit" "http://${ip}/data.lua"`
if [[ "$a" == *"\"apply\":\"ok\"}"* ]]
then
  echo "OK"
else
  echo "Error"
  echo $a
fi
