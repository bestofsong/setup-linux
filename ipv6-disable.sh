#! /usr/bin/env bash

if [ `id -u` -ne 0 ] ; then
	echo "Should run as root"
	exit 255
fi	


config_file="/etc/sysctl.d/99-sysctl.conf"

function comment_out {
	sed -i.bak -e "s/^[^#]*$1/#&/" "$config_file"
}

function append {
	echo $* >>"$config_file"
}

comment_out net.ipv6.conf.all.disable_ipv6
append net.ipv6.conf.all.disable_ipv6 = 1

comment_out net.ipv6.conf.default.disable_ipv6
append net.ipv6.conf.default.disable_ipv6 = 1

comment_out net.ipv6.conf.lo.disable_ipv6
append net.ipv6.conf.lo.disable_ipv6 = 1

sysctl  -p

