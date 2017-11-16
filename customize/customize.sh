#!/bin/sh

rootdir=$1

# copy files and configs the install script will use to VM dir

mkdir ${rootdir}/usr/src/customize
cp -a src/* ${rootdir}/usr/src/customize/

# start the install script on next boot by /etc/rc.local, which will be overwritten by Open Semantic Search bootscript by install script
cp -a src/start_install.sh ${rootdir}/etc/rc.local
