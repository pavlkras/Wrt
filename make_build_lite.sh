#!/bin/bash
#
# Performs lite build from prebuilt binaries.
# Use this script for very lite changes in custom files
#

set -x -e

TOPDIR=$(pwd)
LITEDIR=$TOPDIR/lite

cd $LITEDIR
make clean

# Build firmware
make -j $THREADNUM image
make -j $THREADNUM image PACKAGES="comgt kmod-usb-serial kmod-usb-serial-option usb-modeswitch coreutils-stty kmod-usb-serial-pl2303 curl wget bash luci-teva" FILES=files/

# Copy binaries to target directory
cd $TOPDIR
cp $LITEDIR/bin/ramips/openwrt-ramips-mt7620-wt3020-8M-squashfs-factory.bin $TOPDIR/bin/factory.bin
cp $LITEDIR/bin/ramips/openwrt-ramips-mt7620-wt3020-8M-squashfs-sysupgrade.bin $TOPDIR/bin/sysupgrade.bin
set +e +x
if [[ $(type "banner") ]]
then
    banner "Done!"
fi

exit
