#!/bin/bash

source ../cluster-env.sh
python3 ./configuration/process-xml.py ./configuration/core-site.xml
python3 ./configuration/process-xml.py ./configuration/hdfs-site.xml
python3 ./configuration/process-xml.py ./configuration/mapred-site.xml
python3 ./configuration/process-xml.py ./configuration/yarn-site.xml
cp ./configuration/* $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
wget https://archive.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
tar -xvf hadoop-2.9.0.tar.gz
ln -s hadoop-2.9.0 hadoop
cd hadoop
mkdir dn nn
mv -f $HADOOP_CLUSTER_PATH/*-site.xml etc/hadoop
rm etc/hadoop/slaves
touch etc/hadoop/slaves
echo "$MASTER_NODE" >> etc/hadoop/masters
echo "$MASTER_NODE" >> etc/hadoop/slaves
echo "$SLAVE_NODE" >> etc/hadoop/slaves
