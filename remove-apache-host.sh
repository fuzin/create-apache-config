#!/usr/bin/env bash

# in development mode
# works with .local by default
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ "$1" == "" ];
    then echo "specify hostname"
    exit
fi

cd /etc/apache2/sites-available

# remove from available sites
for f in *.conf; do
  if [[ $f = *"$1"* ]]; then
    #`a2dissite /etc/apache2/sites-enables/$f`
    `rm /etc/apache2/sites-enabled/$f`
    `rm /etc/apache2/sites-available/$f`
  fi
done

# remove from hosts
LINE="127.0.0.1 $1.local"
cmd=`grep -v "$LINE" /etc/hosts > /etc/hosts_tmp`;

echo $LINE
grep -v "$LINE" /etc/hosts > /etc/hosts_tmp
mv /etc/hosts_tmp /etc/hosts

service apache2 reload

