#!/bin/bash
# Install neovim

#####################################################################

echo "=> Build neovim"
yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip > /dev/null
cd /usr/local/src
git clone https://github.com/neovim/neovim
cd neovim
make          > /dev/null
make install  > /dev/null

echo "=> Install python3"
yum -y install zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel > /dev/null
