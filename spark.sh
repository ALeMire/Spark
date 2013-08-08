##### Spark.sh -- a setup script for new VPSs #####
#                                                 #
#  Spark.sh is written for Redhat-based systems.  #
#  Want it for your distro? Send a pull request.  #
###################################################

#!/bin/bash

if [ -f /etc/redhat-release ]; then
  DISTRO=`rpm -qa \*-release | grep -Ei "sl|redhat|centos" | cut -d"-" -f1`
else
  echo "This script is intended for Redhat-based distros."
  exit
fi
