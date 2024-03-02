#! /bin/bash

source ../cluster-env.sh

sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/core-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/hdfs-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/yarn-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/hive-site.xml
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/spark-defaults.conf

sudo cp ../Cluster-Configuration/core-site.xml $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/hdfs-site.xml $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/yarn-site.xml $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/hive-site.xml $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/spark-defaults.conf $HADOOP_CLUSTER_PATH

cd $HADOOP_CLUSTER_PATH

sudo wget https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-without-hadoop.tgz
sudo tar -xvf spark-3.5.1-bin-without-hadoop.tgz
ln -s spark-3.5.1-bin-without-hadoop spark

cd spark
sudo mv -f $HADOOP_CLUSTER_PATH/*-site.xml ./conf
sudo mv -f $HADOOP_CLUSTER_PATH/spark-defaults.conf ./conf

sudo -S chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH

source $HADDOP_SYS_INSTALLER/Hadoop-Base/hadoop-init.sh
hdfs dfs -mkdir /spark3-jars
hdfs dfs -mkdir /spark3-logs
hdfs dfs -put ./jars/* /spark3-jars