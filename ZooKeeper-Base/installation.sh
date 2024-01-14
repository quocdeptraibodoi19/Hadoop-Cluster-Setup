#! /bin/bash

source ../cluster-env.sh
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/zoo.cfg
sudo cp ../Cluster-Configuration/zoo.cfg $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
sudo wget https://archive.apache.org/dist/zookeeper/zookeeper-3.8.3/apache-zookeeper-3.8.3-bin.tar.gz
sudo tar -xvf apache-zookeeper-3.8.3-bin.tar.gz
sudo ln -s apache-zookeeper-3.8.3-bin zookeeper
sudo rm apache-zookeeper-3.8.3-bin.tar.gz
sudo mv -f $HADOOP_CLUSTER_PATH/zoo.cfg $ZOOKEEPER_HOME/conf
sudo -S chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH


