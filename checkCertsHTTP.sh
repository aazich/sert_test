#!/bin/bash


for i in "$@"
do

SERVERNAME="$i"
now_epoch=$( date +%s )
exp_day_soon=10

echo -n "$SERVERNAME:"
expiry_date=$( echo | openssl s_client -showcerts -servername $SERVERNAME -connect $SERVERNAME:443 2>/dev/null | openssl x509 -inform pem -noout -enddate | cut -d "=" -f 2 )
echo -n " $expiry_date";
expiry_epoch=$( date -d "$expiry_date" +%s )
expiry_days="$(( ($expiry_epoch - $now_epoch) / (3600 * 24) ))"
echo "    $expiry_days days"

if [ "$expiry_days" -lt "$exp_day_soon" ]; then
  exit 1
else
#  exit 0
  echo ""
fi

#echo $?

done
