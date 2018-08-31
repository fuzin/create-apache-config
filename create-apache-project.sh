#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ "$1" == "" ];
    then echo "specify hostname"
    exit
fi

LINE="127.0.0.1 $1"
echo "~~~ adding [$LINE] to hosts ~~~~~~~~~~~~~~~~~~"
echo  $LINE >> /etc/hosts

echo "~~~ creating new apache virtual host file ~~~~"
NR_OF_FILES=`cd /etc/apache2/sites-available && ls -a | wc -l`
NR_OF_FILES=`printf %03d $NR_OF_FILES`
VIRTUAL_HOST_FILENAME=`printf $NR_OF_FILES-$1.conf`
VIRTUAL_HOST_PATH=/etc/apache2/sites-available/$VIRTUAL_HOST_FILENAME
echo "$VIRTUAL_HOST_PATH created"


# TODO: repplace with specific apache version file
cp /etc/apache2/sites-available/000-template $VIRTUAL_HOST_PATH
sed -i 's/$HOSTNAME/$1/g' $VIRTUAL_HOST_PATH

