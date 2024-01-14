#! /bin/bash

source ../cluster-env.sh
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/zoo.cfg
sudo -E cp ../Cluster-Configuration/zoo.cfg $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
sudo -E wget https://archive.apache.org/dist/zookeeper/zookeeper-3.8.3/apache-zookeeper-3.8.3-bin.tar.gz
sudo -E tar -xvf apache-zookeeper-3.8.3-bin.tar.gz
sudo -E ln -s apache-zookeeper-3.8.3-bin zookeeper
sudo -E rm apache-zookeeper-3.8.3-bin.tar.gz
sudo -E mv -f $HADOOP_CLUSTER_PATH/zoo.cfg $ZOOKEEPER_HOME/conf


