#!/bin/bash
#
# Performs buildmachine deployment. Further full build required
#

set -x -e

TOPDIR=$(pwd)

#
# Deploy section
#
mkdir bin lite full web

# Linking main files dir to lite build
cd $TOPDIR/lite
ln -s ../files files

# Linking web dirs
cd $TOPDIR/web
ln -s ../deploy/feeds/luci/modules/luci-mod-teva mod-teva
ln -s ../deploy/feeds/luci/themes/luci-theme-bs-teva theme-teva

# Extracting and configuring buidmachine
cd $TOPDIR/full
git clone git://git.openwrt.org/15.05/openwrt.git .
cp -r $TOPDIR/deploy/fulldiffconfig $TOPDIR/full/fulldiffconfig
cp -r $TOPDIR/deploy/basediffconfig $TOPDIR/full/basediffconfig
ln -s ../files files

# Adding working mirror for several files downloading
cd $TOPDIR
sed -i '/push @mirrors, \x27http:\x2f\x2fdownloads.openwrt.org\x2fsources\x27;/a push\x20@mirrors,\x20\x27http:\x2f\x2fbuildbot.openwrt.org:8010\x2fsrc\x2f\x27;' full/scripts/download.pl

# Type banner
set +e +x
if [[ $(type "banner") ]]
then
	banner "Done!"
fi

exit
