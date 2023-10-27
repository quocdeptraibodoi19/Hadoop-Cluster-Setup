#! /bin/bash

source ../cluster-env.sh
if [ ! -d  "${ZOOKEEPER_HOME}/data" ]; then
    echo "Creating a ZOOKEEPER Cluster Data Folder..."
    sudo ssh hadoop@$MASTER_NODE "sudo -S mkdir ${ZOOKEEPER_HOME}/data"
    sudo ssh hadoop@$SLAVE_NODE "sudo -S mkdir ${ZOOKEEPER_HOME}/data"

    echo "Creating myid File for Zookeeper Cluster..."
    sudo ssh hadoop@$MASTER_NODE "echo '1' | sudo -S tee -a ${ZOOKEEPER_HOME}/data/myid"
    sudo ssh hadoop@$SLAVE_NODE "echo '2' | sudo -S tee -a ${ZOOKEEPER_HOME}/data/myid"
fi

zkServer.sh start
zkServer.sh status