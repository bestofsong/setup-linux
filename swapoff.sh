#! /bin/sh

set -e

user_id=`id -u`
if [ "$user_id" -ne 0 ] ; then
  echo "UID: $user_id is not root"
  exit 255
fi

swapoff -a

echo "Before comment out:"
grep 'swap' /etc/fstab
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
echo "After comment out:"
grep 'swap' /etc/fstab

