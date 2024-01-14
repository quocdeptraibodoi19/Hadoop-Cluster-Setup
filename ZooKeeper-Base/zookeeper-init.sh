#! /bin/bash

# This can be triggered on either of 2 nodes
source ../cluster-env.sh
if [ ! -d  "${ZOOKEEPER_HOME}/data" ]; then
    echo "Creating a ZOOKEEPER Cluster Data Folder..."
    sudo -E ssh hadoop@$MASTER_NODE "sudo -S mkdir ${ZOOKEEPER_HOME}/data && \
        echo '1' | sudo tee -a ${ZOOKEEPER_HOME}/data/myid && \
        sudo -S chown hadoop:hadoop -R ${ZOOKEEPER_HOME}/data"
    sudo -E ssh hadoop@$SLAVE_NODE "sudo -S mkdir ${ZOOKEEPER_HOME}/data && \
        echo '2' | sudo tee -a ${ZOOKEEPER_HOME}/data/myid && \
        sudo -S chown hadoop:hadoop -R ${ZOOKEEPER_HOME}/data"
fi

sudo -E ssh hadoop@$MASTER_NODE "sudo -S service ssh restart && \
    ${ZOOKEEPER_HOME}/bin/zkServer.sh start"
sudo -E ssh hadoop@$SLAVE_NODE "sudo -S service ssh restart && \
    ${ZOOKEEPER_HOME}/bin/zkServer.sh start"

zkServer.sh status