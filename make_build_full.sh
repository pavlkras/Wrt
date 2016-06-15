#!/bin/bash
#
# Performs full build from the scratch and prepares lite build sources

set -x
rm -r bin/*
set -e

TOPDIR=$(pwd)
SRCDIR=$TOPDIR/full
let THREADNUM=$(nproc)+1

# Make binaries build
cd $SRCDIR
./scripts/feeds update -a
cp -r $TOPDIR/deploy/feeds/luci/* $TOPDIR/full/feeds/luci
./scripts/feeds update -i
./scripts/feeds install luci-teva coreutils wget bash
cp basediffconfig .config
make defconfig
make -j $THREADNUM
cp fulldiffconfig .config
make defconfig
make -j $THREADNUM

# Copy binaries to target directory
cd $TOPDIR
cp $SRCDIR/bin/ramips/openwrt-ramips-mt7620-wt3020-8M-squashfs-factory.bin bin/factory.bin
cp $SRCDIR/bin/ramips/openwrt-ramips-mt7620-wt3020-8M-squashfs-sysupgrade.bin bin/sysupgrade.bin

# Deploy sources for lite build
cd $TOPDIR
mkdir tmp
tar xpvjf full/bin/ramips/OpenWrt-ImageBuilder-ramips-mt7620.Linux-x86_64.tar.bz2 -C tmp
cp -r tmp/OpenWrt-ImageBuilder-ramips-mt7620.Linux-x86_64/* lite/
cp -r tmp/OpenWrt-ImageBuilder-ramips-mt7620.Linux-x86_64/.[a-zA-Z0-9]* lite/
rm -rf tmp

set +e +x
if [[ $(type "banner") ]]
then
	banner "Done!"
fi

exit
