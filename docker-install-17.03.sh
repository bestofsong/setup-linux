#! /bin/sh

if [ $# -lt 1 ] ; then
	echo "Usage: $0 <user_name_to_add_to_docker_group>"
	exit 255
fi

target_user=$1

set -e

if [ `id -u` -ne 0 ] ; then
  echo "UID `id -u` is not root"
  exit 255
fi

if ! which docker >/dev/null ; then
	apt-get update
	apt-get install -y apt-transport-https ca-certificates curl software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
	apt-get update && apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')

fi

groupadd docker 2>/dev/null || printf ''
if ! groups $target_user | grep docker >/dev/null ; then
	echo "user: $target_user not in docker group, enrolling .."
	usermod -aG docker $target_user
fi

