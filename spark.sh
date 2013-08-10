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


function yum_remove_groups()
{
  IFS=$'\n'
  to_uninstall=( $( yum grouplist| awk '/Installed Groups:/ {flag=1;next} /Available Groups:/{flag=0} flag {print}' ) )

  for idx in $(seq 0 $((${#to_uninstall[@]} - 1))); do
        group_rem="${to_uninstall[$idx]}"
        yum -y groupremove "$group_rem"
  done
}

function lowercase()
{
  echo $1 | tr '[:uppper]' '[:lower]'
}

function add_user()
{
  USERNAME=`lower $1`
  USERGROUPS=$2 
  USERSHELL=$3
  USERPASSWORD=$4

  useradd -m -G "$USERGROUPS" -s "$USERSHELL" "$USERNAME"
  echo "$USERNAME:$USERPASSWORD" | chpasswd 
}
