#!/bin/bash

sudo python3 ./configuration/process-xml.py ./configuration/core-site.xml
sudo python3 ./configuration/process-xml.py ./configuration/hdfs-site.xml
sudo python3 ./configuration/process-xml.py ./configuration/mapred-site.xml
sudo python3 ./configuration/process-xml.py ./configuration/yarn-site.xml
sudo cp ./configuration/*-site.xml $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
wget https://archive.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
tar -xvf hadoop-2.9.0.tar.gz
sudo rm hadoop-2.9.0.tar.gz
ln -s hadoop-2.9.0 hadoop
cd hadoop
sudo mkdir dn nn
sudo mv -f $HADOOP_CLUSTER_PATH/*-site.xml etc/hadoop
sudo rm etc/hadoop/slaves
touch etc/hadoop/slaves
echo "$MASTER_NODE" | sudo tee -a etc/hadoop/masters
echo "$MASTER_NODE" | sudo tee -a etc/hadoop/slaves
echo "$SLAVE_NODE" | sudo tee -a etc/hadoop/slaves
echo "export JAVA_HOME=${JAVA_HOME}" | sudo tee -a etc/hadoop/hadoop-env.sh