#! /bin/bash

# This can be triggered on either of 2 nodes
sudo ssh hadoop@$MASTER_NODE "sudo -S service ssh restart && \
    ${ZOOKEEPER_HOME}/bin/zkServer.sh stop"
sudo ssh hadoop@$SLAVE_NODE "sudo -S service ssh restart && \
    ${ZOOKEEPER_HOME}/bin/zkServer.sh stop"

zkServer.sh status