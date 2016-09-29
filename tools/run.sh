#!/bin/bash

#####################################################################

yum -y install epel-release
sed -i "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/epel.repo
yum -y install ansible --enablerepo=epel


#
# echo "=> Cron package"
# yum -y remove cronie-anacron    > /dev/null
# yum -y install cronie-noanacron > /dev/null
# systemctl enable crond          > /dev/null
# systemctl start crond           > /dev/null
#
# echo "=> NTP client"
# yum -y install chrony     > /dev/null
# systemctl start chronyd   > /dev/null
# systemctl enable chronyd  > /dev/null
# chronyc sources           > /dev/null
#
# echo "=> Backup"
# echo "  => Create backup group..."
# groupadd backup
# echo "  => Create backup user..."
# useradd -g backup -s /bin/false backup
# echo
#
# echo "=> Change shell"
# chsh -s /bin/zsh
