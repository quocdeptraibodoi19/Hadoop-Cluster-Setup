#!/bin/bash

source ../cluster-env.sh
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/core-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/hdfs-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/mapred-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/yarn-site.xml
sudo -E cp ../Cluster-Configuration/*-site.xml $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
sudo -E wget https://archive.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
sudo -E tar -xvf hadoop-2.9.0.tar.gz
sudo -E rm hadoop-2.9.0.tar.gz
sudo -E ln -s hadoop-2.9.0 hadoop
cd hadoop
sudo -E mkdir dn nn
sudo -E mv -f $HADOOP_CLUSTER_PATH/*-site.xml etc/hadoop
sudo -E rm etc/hadoop/slaves
sudo -E touch etc/hadoop/slaves
echo "$MASTER_NODE" | sudo -E tee -a etc/hadoop/masters
echo "$MASTER_NODE" | sudo -E tee -a etc/hadoop/slaves
echo "$SLAVE_NODE" | sudo -E tee -a etc/hadoop/slaves
echo "export JAVA_HOME=${JAVA_HOME}" | sudo -E tee -a etc/hadoop/hadoop-env.sh
