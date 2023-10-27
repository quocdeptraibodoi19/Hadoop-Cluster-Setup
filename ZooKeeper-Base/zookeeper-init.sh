#! /bin/bash

source ../cluster-env.sh
if [ ! -d  "${ZOOKEEPER_HOME}/data" ]; then
    echo "Creating a ZOOKEEPER Cluster Data Folder..."
    sudo ssh hadoop@$MASTER_NODE "sudo -S mkdir ${ZOOKEEPER_HOME}/data && \
        echo '1' | sudo tee -a ${ZOOKEEPER_HOME}/data/myid && \
        sudo -S chown hadoop:hadoop -R ${ZOOKEEPER_HOME}/data"
    sudo ssh hadoop@$SLAVE_NODE "sudo -S mkdir ${ZOOKEEPER_HOME}/data && \
        echo '2' | sudo tee -a ${ZOOKEEPER_HOME}/data/myid && \
        sudo -S chown hadoop:hadoop -R ${ZOOKEEPER_HOME}/data"
fi

zkServer.sh start
zkServer.sh status