#!/bin/bash

sudo dnf -y update && sudo dnf -y install automake libtool autoconf autoconf-archive libstdc++-devel gcc pkg-config uriparser-devel libgcrypt-devel dbus-devel glib2-devel compat-openssl10-devel libcurl-devel PyYAML git vim

cd /root
git clone https://github.com/keylime/tpm2-tools.git
git clone https://github.com/tpm2-software/tpm2-tss.git
git clone https://github.com/tpm2-software/tpm2-abrmd.git
mkdir ibmtpm
cd /root/ibmtpm
wget --content-disposition http://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1119.tar.gz/download
tar -zxvf ibmtpm1119.tar.gz

cd /root/tpm2-tss
git checkout 1765642
./bootstrap
./configure --prefix=/usr --disable-doxygen-doc
make
make install

cd /root/tpm2-tools
./bootstrap
SAPI_CFLAGS=' ' SAPI_LIBS='-ltss2-sys -L/usr/lib/' ./configure --prefix=/usr/local
make
make install

cd /root/tpm2-abrmd
git checkout 642ca16
./bootstrap
TSS2_SYS_CFLAGS=' ' TSS2_SYS_LIBS='-ltss2-sys -L/usr/lib/' ./configure --prefix=/usr
make
make install
ldconfig

cd /root/ibmtpm/src
make
install -c tpm_server /usr/local/bin/tpm_server


