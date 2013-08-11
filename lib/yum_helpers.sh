#!/bin/sh

function yum_remove_groups()
{
  IFS=$'\n'
  to_uninstall=( $( yum grouplist| awk '/Installed Groups:/ {flag=1;next} /Available Groups:/{flag=0} flag {print}' ) )

  for idx in $(seq 0 $((${#to_uninstall[@]} - 1))); do
        group_rem="${to_uninstall[$idx]}"
        yum -y groupremove "$group_rem"
  done
}

function yum_clean_leaves()
{
  if [ -f /usr/bin/package-cleanup ]; then
    yum -y install yum-utils
  fi
  
  package-cleanup --leaves --quiet | xargs yum remove -y
}
  
function yum_update()
{
  yum -y update
}
