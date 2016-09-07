#!/bin/bash
# Install neovim

#####################################################################

echo "=> Install neovim"
cat << EOF > /etc/yum.repos.d/dperson-neovim-epel-7.repo
[dperson-neovim]
name=Copr repo for neovim owned by dperson
baseurl=https://copr-be.cloud.fedoraproject.org/results/dperson/neovim/epel-7-\$basearch/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://copr-be.cloud.fedoraproject.org/results/dperson/neovim/pubkey.gpg
enabled=0
EOF

yum -y install neovim --enablerepo=dperson-neovim,epel
