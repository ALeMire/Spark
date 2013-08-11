#!/bin/sh

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

function cfile_number()
{
}

