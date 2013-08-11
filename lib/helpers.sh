#!/bin/sh

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
