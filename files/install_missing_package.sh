#!/bin/sh

PKG=$1
DEBIAN_FRONTEND="noninteractive"
export DEBIAN_FRONTEND

# Check for existing install. Cannot rely on exit code from "dpkg --status",
# since it doesn't change after a package has been manually removed. This
# solution is actually the most reliable (and horrible) way to solve this...
if [ "$(dpkg-query -W --showformat='${Status}' $PKG 2>/dev/null)" = "install ok installed" ] ; then
    exit 0
fi

echo "Installing $PKG..."
(apt-get --yes update && apt-get --yes install $PKG) > /dev/null 2>&1
exit $?
