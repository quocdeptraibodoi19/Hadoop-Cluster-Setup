#! /bin/bash

# This can be triggered on either of 2 nodes
sudo -E ssh hadoop@$MASTER_NODE "sudo -S service ssh restart && \
    ${ZOOKEEPER_HOME}/bin/zkServer.sh stop"
sudo -E ssh hadoop@$SLAVE_NODE "sudo -S service ssh restart && \
    ${ZOOKEEPER_HOME}/bin/zkServer.sh stop"

zkServer.sh status