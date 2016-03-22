#!/bin/bash -v

NODENAME=${hostname}

sudo hostname $NODENAME
sudo echo $NODENAME > /etc/hostname 