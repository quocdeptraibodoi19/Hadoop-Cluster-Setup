#!/bin/bash

source ../cluster-env.sh
cp ../configuration/* $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
wget https://archive.apache.org/dist/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz
tar -xvf hadoop-2.9.0.tar.gz
ln -s hadoop-2.9.0.tar.gz hadoop
cd hadoop
mkdir dn nn
mv -f $HADOOP_CLUSTER_PATH/*-xite.xml etc/hadoop

echo "$MASTER_NODE" >> etc/hadoop/masters
echo "$MASTER_NODE" >> etc/hadoop/slaves
echo "$SLAVE_NODE" >> etc/hadoop/slaves
