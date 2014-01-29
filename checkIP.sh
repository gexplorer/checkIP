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

DEPS=`which sendemail`

if [[ $DEPS = "" ]]; then
	echo "The program 'sendemail' is currently not installed. You can install it by typing:"
	echo "sudo apt-get install sendemail"
	exit 1;
fi

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