#!/bin/bash

source ./cluster-env.sh

if [ ! -d "$HADOOP_CLUSTER_PATH" ]; then
    mkdir $HADOOP_CLUSTER_PATH
    echo "Creaking a Hadoop Cluster Folder..."
fi

apt -y update && apt install -y wget openssh-server openjdk-8-jdk python3 sudo
service ssh restart

sudo adduser hadoop
sudo usermod -aG sudo hadoop
su hadoop

cat ./cluster-env.sh | sudo tee -a ~/.bashrc
source ~/.bashrc
sudo chown -R hadoop:hadoop $(pwd)
sudo chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH