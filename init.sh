#!/bin/bash
# Common install script for Centos 7.2-1511

#####################################################################

echo "=> System update"
yum -y update > /dev/null
yum clean all > /dev/null

echo "=> Disable selinux"
setenforce 0
sed -i "s/^SELINUX=.*/SELINUX=disabled/" /etc/selinux/config

#echo '=> GRUB'
#sed -i.orig -r '/^GRUB_CMDLINE_LINUX=/s/\s+rhgb//' /etc/default/grub
#grub2-mkconfig -o /boot/grub2/grub.cfg

echo "=> Set for only the administrator can become a root"
sed -i 's/^.*auth.*required.*pam_wheel.so use_uid/auth\t\trequired\tpam_wheel.so use_uid/g' /etc/pam.d/su

echo "=> Accept sudo without the only wheel group"
sed -i "s/^Defaults.*requiretty/Defaults:%wheel    !requiretty/" /etc/sudoers

echo "=> sudo secure path"
sed -i "s/^Defaults    secure_path.*/Defaults    secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin:\/usr\/local\/bin/" /etc/sudoers

echo "=> Repository"
echo "  => epel"
rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
yum -y install epel-release > /dev/null
sed -i "s/mirrorlist=https/mirrorlist=http/"  /etc/yum.repos.d/epel.repo
sed -i "s/enabled *= *1/enabled=0/g"          /etc/yum.repos.d/epel.repo
echo "  => remi"
rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
rpm -ivh     http://rpms.famillecollet.com/enterprise/remi-release-7.rpm > /dev/null
sed -i "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/remi.repo
sed -i "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/remi-safe.repo
echo "  => rpmForge"
rpm -ivh http://ftp.riken.jp/Linux/dag/redhat/el7/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el7.rf.x86_64.rpm > /dev/null
sed -i "s/enabled *= *1/enabled=0/g" /etc/yum.repos.d/rpmforge.repo
echo

echo "=> Package"
echo "  => sudo..." && yum -y install sudo > /dev/null
echo "  => wget..." && yum -y install wget > /dev/null
echo "  => nmap..." && yum -y install nmap > /dev/null
echo "  => zsh...." && yum -y install zsh  > /dev/null
echo "  => htop..." && yum -y install htop --enablerepo=epel > /dev/null
echo "  => screen..." && yum -y install screen > /dev/null
echo

echo "=> Cron package"
yum -y remove cronie-anacron    > /dev/null
yum -y install cronie-noanacron > /dev/null
systemctl enable crond          > /dev/null
systemctl start crond           > /dev/null

echo "=> NTP client"
yum -y install chrony     > /dev/null
systemctl start chronyd   > /dev/null
systemctl enable chronyd  > /dev/null
chronyc sources           > /dev/null

echo "=> chef-client"
curl -s -S -L https://www.opscode.com/chef/install.sh | bash
echo

echo "=> Backup"
echo "  => Create backup group..."
groupadd backup
echo "  => Create backup user..."
useradd -g backup -s /bin/false backup
echo

echo "=> Change shell"
chsh -s /bin/zsh
