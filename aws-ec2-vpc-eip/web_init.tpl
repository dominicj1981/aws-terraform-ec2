#!/bin/bash -v

NODENAME=${hostname}

sudo hostname $NODENAME
sudo echo $NODENAME > /etc/hostname 

sudo service salt-minion stop
sudo rm /etc/salt/pki/minion/minion.pem
sudo rm /etc/salt/pki/minion/minion.pub
sudo cat /dev/null > /etc/salt/minion_id
sudo rm -r /var/cache/salt/*

sudo service salt-minion start
