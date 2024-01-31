#!/bin/bash

if [ ! -d "./first_init" ]; then
  while true; do
      echo "Please input type of OS (mac, or win): "
      read os_type
      if [ "$os_type" == "mac" ] || [ "$os_type" = "win" ]; then
          if [ "$os_type" == "mac" ]; then
            export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-arm64
          else
            export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
          fi
          echo "export JAVA_HOME=${JAVA_HOME}" | sudo tee -a ./cluster-env.sh
          break
      else
          echo "Invalid input. Please enter either 'mac' or 'win'."
      fi
  done
fi

source ./cluster-env.sh

if [ ! -d "$HADOOP_CLUSTER_PATH" ]; then
    sudo mkdir $HADOOP_CLUSTER_PATH
    echo "Creating a Hadoop Cluster Folder..."
fi

if ! id "hadoop" &> /dev/null ; then
  echo "Creating a user for Hadoop Cluster..."
  sudo adduser hadoop
  sudo usermod -aG sudo hadoop
fi

if [ ! -d "./first_init" ]; then
  mkdir first_init
  sudo apt -y update && sudo apt install -y wget openssh-server openjdk-8-jdk python3 sudo
    su hadoop -c "
    cat ./cluster-env.sh | tee -a ~/.bashrc > /dev/null && \
    source ~/.bashrc && \
    sudo -S chown -R hadoop:hadoop $(pwd) && \
    sudo -S chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH
  "
fi
sudo service ssh restart

su hadoop