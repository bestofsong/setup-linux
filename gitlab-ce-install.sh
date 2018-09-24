#! /usr/bin/env bash

if [ $# -lt 1 ] ; then
	echo "Usage: $0 <EXTERNAL_URL(http://...)>"
	exit 255
fi 

external_url=$1

apt-get update
apt-get install -y curl openssh-server ca-certificates
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
EXTERNAL_URL="$external_url" apt-get install gitlab-ce

