#!/bin/bash
cat /tmp/hosts | grep nodename | while read line
do
  for word in `echo $line`
  do
    for key in `echo $word`
    do
      if [[ $key == *ansible_ssh_host* ]]
      then
        ip=`echo $word | grep ansible_ssh_host | cut -d "=" -f2`
      fi

      if [[ $key == *nodename* ]]
      then
        host=`echo $word | grep nodename | cut -d "=" -f2`
      fi
    done
  done
  echo $ip $host>>/etc/hosts
done

