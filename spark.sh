##### Spark.sh -- a setup script for new VPSs #####
#                                                 #
#  Spark.sh is written for Redhat-based systems.  #
#  Want it for your distro? Send a pull request.  #
###################################################

#!/bin/bash


if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

if [ -f /etc/redhat-release ]; then
  DISTRO=`rpm -qa \*-release | grep -Ei "sl|redhat|centos" | cut -d"-" -f1`
else
  echo "This script is intended for Redhat-based distros."
  exit 1
fi

yum_update
yum_remove_groups
yum_remove_leaves
yum_update
