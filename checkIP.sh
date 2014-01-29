#!/bin/bash
IP=`wget -q -O - http://www.biranchi.com/ip.php`
SCRIPTSHOME=$(dirname $0)
IPLOG=$SCRIPTSHOME/last.ip

#SMTP Config
SMTP=smtp.host.com
USERNAME=username@host.com
PASSWORD=password

#Send email to
TO=to@host.com

SUBJECT='IP Address'

if [ ! -f "$IPLOG" ]; then
    touch $IPLOG
fi

LASTIP=`cat $IPLOG`
if [[ "$LASTIP" != "$IP" ]]; then
    M="Current IP $IP was $LASTIP"
    echo $M
    echo $IP > $IPLOG
    sendemail -u $SUBJECT -s $SMTP -t $TO -f $USERNAME -m $M -xu $USERNAME -xp $PASSWORD -o tls=yes
else
    echo "Current IP $IP didn't change"
fi

exit 0