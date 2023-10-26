#!/bin/bash

# this is just on the the master node
service ssh restart
ssh-keygen -t rsa -P “”
cat $HOME/.ssh/id_rsa.pub >> $HOME/.ssh/authorized_keys
ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@$SLAVE_NODE
