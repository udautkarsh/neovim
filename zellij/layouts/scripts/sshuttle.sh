#!/bin/bash
rm -f /tmp/sshuttle.log
touch /tmp/sshuttle.log
/usr/bin/nohup /usr/bin/sshuttle -v -r bastion1 172.18.247.0/22 172.18.251.0/22 172.30.8.0/23 > /tmp/sshuttle.log 2>&1 &
#sshuttle -v -r bastion1 172.18.247.0/22 172.18.251.0/22 172.30.8.0/23  
