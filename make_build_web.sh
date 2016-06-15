#!/bin/bash
#
# Recompiles web modules and performs rebuild with prebuilt binaries
# Use this script to apply changes in web modules and custom files
#

set -x -e

TOPDIR=$(pwd)
SRCDIR=$TOPDIR/deploy/feeds/luci
LUCIDIR=$TOPDIR/full/feeds/luci

# Refresh web modules repository
rm -rf $LUCIDIR/modules/luci-mod-teva $LUCIDIR/themes/luci-theme-bs-teva
cp -r $SRCDIR/modules/luci-mod-teva $LUCIDIR/modules
cp -r $SRCDIR/themes/luci-theme-bs-teva $LUCIDIR/themes

# Compile modules
cd $TOPDIR/full
./scripts/feeds update -i
./scripts/feeds install luci-teva
make package/cleanup
make package/feeds/luci/luci-teva/compile

# Copy binaries to target directory
cd $TOPDIR/full/bin/ramips/packages/luci
for file in *teva*
do
	cp "$file" $TOPDIR/lite/packages/luci
done

# Compile firmware
cd $TOPDIR
./make_build_lite.sh

exit
