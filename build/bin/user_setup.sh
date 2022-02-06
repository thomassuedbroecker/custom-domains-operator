#!/bin/sh
set -x

# ensure $HOME exists and is accessible by group 0 (we don't know what the runtime UID will be)
export USER_UID=1001
export USER_NAME=custom-domains-operator

echo "User HOME: $HOME"
echo "${USER_NAME}:x:${USER_UID}:0:${USER_NAME} user:${HOME}:/sbin/nologin" >> /etc/passwd
mkdir -p ${HOME}
chown ${USER_UID}:0 ${HOME}
chmod ug+rwx ${HOME}

# no need for this script to remain in the image after running
rm $0
