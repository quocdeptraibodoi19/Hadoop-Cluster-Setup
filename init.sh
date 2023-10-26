#!/bin/bash

source ./cluster-env.sh

if [! -d "$HADOOP_CLUSTER_PATH"]; then
    mkdir -p $HADOOP_CLUSTER_PATH
    echo "Creaking a Hadoop Cluster Folder..."
fi

apt -y update && apt install -y wget openssh-server openjdk-8-jdk
service ssh restart