#!/bin/bash

cat ./cluster-env.sh >> ~/.bashrc
source ~/.bashrc

if [ ! -d "$HADOOP_CLUSTER_PATH" ]; then
    mkdir -p $HADOOP_CLUSTER_PATH
    echo "Creaking a Hadoop Cluster Folder..."
fi

apt -y update && apt install -y wget openssh-server openjdk-8-jdk python3 sudo
service ssh restart
