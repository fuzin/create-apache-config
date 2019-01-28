#!/usr/bin/env bash

############################################################
## System Procedure For Adding new hostname to httpd server
#
# dev
# by default .local, apache 2.4
# TODO: recognize $SERVER and install appropriate config
# [apache 2.2, apache 2.4, nginx]
#############################################################

if [ "$EUID" -ne 0 ]
  then echo "run as root"
  exit
fi

if [ "$1" == "" ];
    then echo "specify hostname as first parameter Example: 'dev' for http://dev.local"
    exit
fi

if [ "$2" == "" ];
    then echo "specify user as second parameter - apache will run as this user"
    exit
fi

echo "DocumentRoot (Public directory): $PWD"
echo "Use '$PWD' [Press Return] or insert custom path:"
read PUBLIC_DIR

if [ -z $PUBLIC_DIR ]
    then PUBLIC_DIR=$PWD
fi

LINE="127.0.0.1 $1.local"
echo "~~~ adding [$LINE] to hosts ~~~~~~~~~~~~~~~~~~"
echo  $LINE >> /etc/hosts
echo "."
echo "~~~ creating new apache virtual host file ~~~~"

NR_OF_FILES=`cd /etc/apache2/sites-available && ls -a | wc -l`
NR_OF_FILES=`echo $((NR_OF_FILES - 2))`
NR_OF_FILES=`printf %03d $NR_OF_FILES`

echo "."

VIRTUAL_HOST_FILENAME=`printf $NR_OF_FILES-$1.local.conf`
VIRTUAL_HOST_PATH=/etc/apache2/sites-available/$VIRTUAL_HOST_FILENAME

# TODO: replace with system recognition and template download or throw Exception if not found
cp /etc/apache2/sites-available/000-template $VIRTUAL_HOST_PATH

echo "$VIRTUAL_HOST_PATH created"
echo "."

# replace $HOSTNAME in file with 1. parameter
CMD='s/$HOSTNAME/'
CMD+="$1/g";
sed -i $CMD $VIRTUAL_HOST_PATH

# replace $PUBLIC_DIR with current path;
CMD='s#$PUBLIC_DIR#'
CMD+="$PUBLIC_DIR#g";
sed -i $CMD $VIRTUAL_HOST_PATH

# replace $USER and $GROUP with current system user / group
CMD='s/$USER/'
# CMD+="$USER/g" - user is root : has to be parameter
CMD+="$2/g"
sed -i $CMD $VIRTUAL_HOST_PATH

CMD='s/$GROUP/'
# GROUP=`id -g -n` - group will always be root use user for the moment
CMD+="$2/g"
set -i $CMD $VIRTUAL_HOST_PATH

echo "Visit: http://$1.local"
a2ensite $VIRTUAL_HOST_FILENAME
/etc/init.d/apache2 reload
