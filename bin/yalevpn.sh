#!/bin/bash
# Copied from http://sprackle.org/2013/12/cisco-anyconnect-with-a-chromebook/

# YaleVPN setup
SSLVpn="access.yale.edu"
SearchDomain="yale.edu"
DNSServer="8.8.8.8"

# ensure running as root
if [ "$(id -u)" != "0" ]; then
	exec sudo "$0" "$@" 
fi
if [ ! -f /dev/net/tun ]; then
	        tunctl -t tap1 -f /dev/net/tun 
fi

mknod /dev/net/tun0 c 10 200

cp /etc/resolv.conf ~/.resolv.conf
echo "nameserver ${DNSServer}" > /etc/resolv.conf
echo "search ${SearchExample}" >> /etc/resolv.conf
cat ~/.resolv.conf >> /etc/resolv.conf
openconnect -s /etc/vpnc/vpnc-script ${SSLVpn}
cat ~/.resolv.conf > /etc/resolv.conf
rm /dev/net/tun0
