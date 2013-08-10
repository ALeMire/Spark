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
  user_name=`lower $1`
  user_groups=$2 
  user_shell=$3
  user_password=$4

  useradd -m -G "$user_groups" -s "$user_shell" "$user_name"
  echo "$user_name:$user_password" | chpasswd 
}

function cfile_yes_no()
{
  directive=$1
  bool_value=`lowercase $2`
  config_file=$3
  
  if [ "$bool_value" == "yes" ] || [ "$bool_value" == "no" ]; then
    sed -i "s/^#*\($directive\).*/\1 $bool_value/" $config_file
  fi
}

function cfile_0_1()
{
  directive=$1
  bool_value=$2
  config_file=$3
  
  if [ "$bool_value" == "0" ] || [ "$bool_value" == "1" ]; then
    sed -i "s/^#*\($directive\).*/\1 $bool_value/" $config_file
  fi
}


