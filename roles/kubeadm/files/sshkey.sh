#!/bin/bash
sed -i '/PermitRootLogin/s/^#//; /PermitRootLogin/s/yes/yes/' /etc/ssh/sshd_config
sed -i '/UseDNS/s/^#//; /UseDNS/s/yes/no/' /etc/ssh/sshd_config
sed -i '/GSSAPIAuthentication/s/^#//; /GSSAPIAuthentication/s/yes/no/' /etc/ssh/sshd_config
sed -i '/StrictHostKeyChecking/s/^#//; /StrictHostKeyChecking/s/ask/no/' /etc/ssh/ssh_config
[ ! -f /root/.ssh/id_rsa.pub ] && ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa &>/dev/null
cat /etc/ansible/hosts | grep nodename | while read line
do
  for word in `echo $line`
  do
    for key in `echo $word`
    do
      if [[ $key == *ansible_ssh_host* ]]
      then
        ip=`echo $word | grep ansible_ssh_host | cut -d "=" -f2`
      fi

      if [[ $key == *ansible_ssh_pass* ]]
      then
        passwd=`echo $word | grep ansible_ssh_pass | cut -d "=" -f2`
      fi

      if [[ $key == *ansible_ssh_user* ]]
      then
        user=`echo $word | grep ansible_ssh_user | cut -d "=" -f2`
      fi

    done
  done
  sshpass -p $passwd ssh-copy-id -o StrictHostKeyChecking=no $user@$ip
done
