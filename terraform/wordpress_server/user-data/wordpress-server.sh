#!/bin/bash

# get instance metadata from aws
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
LOCAL_IPV4=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
IPADDR=$(printf %03d $(echo $LOCAL_IPV4 | cut -d '.' -f4))
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
REGION=$(echo $AVAILABILITY_ZONE | rev | cut -c 2- | rev)
ENV="${env}"

if [[ $AVAILABILITY_ZONE =~ ap-[a-zA-Z0-9]+-1a ]]; then
  az="a"
elif [[ $AVAILABILITY_ZONE =~ ap-[a-zA-Z0-9]+-1c ]]; then
  az="c"
fi

# set hostname
linux_hostname=wordpress-server-$az$IPADDR

echo $linux_hostname > /etc/hostname
hostname $linux_hostname
echo -e "$LOCAL_IPV4\t$linux_hostname" >> /etc/hosts

