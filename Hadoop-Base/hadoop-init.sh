#!/bin/bash

# This is just invoked as soon as the download and setup operations are already done in the whole cluster
# Just run on either master or slave
source ../cluster-env.sh
sudo ssh hadoop@$MASTER_NODE "sudo -S service ssh restart"
sudo ssh hadoop@$SLAVE_NODE "sudo -S service ssh restart"
hdfs namenode -format
start-dfs.sh
start-yarn.sh
mr-jobhistory-daemon.sh start historyserver
yarn-daemon.sh start historyserver