#!/bin/sh           
opkg update
opkg install comgt kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan usb-modeswitch
opkg install luci-ssl luci-proto-3g luci-app-samba
opkg install coreutils-stty
opkg install kmod-usb-serial-pl2303
opkg install curl
opkg install wget
opkg install bash
opkg install vim
/etc/init.d/cron start
/etc/init.d/cron enable
/root/addcron.sh
#cp /root/tools/tevaServ.serv /etc/init.d/tevaServ.serv
#/etc/init.d/tevaServ.serv enable
echo "alias ll='ls -l'" >> /etc/profile
#disconnect console from linux (make uart available)
cp /root/data/inittab /etc/inittab
#reboot
