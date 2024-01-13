#!/bin/bash

source ../cluster-env.sh
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/core-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/hdfs-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/mapred-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/yarn-site.xml
sudo cp ../Cluster-Configuration/*-site.xml $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
sudo wget https://archive.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
sudo tar -xvf hadoop-2.9.0.tar.gz
sudo rm hadoop-2.9.0.tar.gz
sudo ln -s hadoop-2.9.0 hadoop
cd hadoop
sudo mkdir dn nn
sudo mv -f $HADOOP_CLUSTER_PATH/*-site.xml etc/hadoop
sudo rm etc/hadoop/slaves
sudo touch etc/hadoop/slaves
echo "$MASTER_NODE" | sudo tee -a etc/hadoop/masters
echo "$MASTER_NODE" | sudo tee -a etc/hadoop/slaves
echo "$SLAVE_NODE" | sudo tee -a etc/hadoop/slaves
echo "export JAVA_HOME=${JAVA_HOME}" | sudo tee -a etc/hadoop/hadoop-env.sh
