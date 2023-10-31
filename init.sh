#!/bin/bash

source ./cluster-env.sh

if [ ! -d "$HADOOP_CLUSTER_PATH" ]; then
    sudo mkdir $HADOOP_CLUSTER_PATH
    echo "Creating a Hadoop Cluster Folder..."
fi

sudo apt -y update && sudo apt install -y wget openssh-server openjdk-8-jdk python3 sudo
sudo service ssh restart

if [ ! id "hadoop" &> /dev/null ]; then
  echo "Creating a user for Hadoop Cluster..."
  sudo adduser hadoop
  sudo usermod -aG sudo hadoop
  su hadoop -c "
    cat ./cluster-env.sh | tee -a ~/.bashrc > /dev/null && \
    source ~/.bashrc && \
    sudo -S chown -R hadoop:hadoop $(pwd) && \
    sudo -S chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH
"
fi
su hadoop