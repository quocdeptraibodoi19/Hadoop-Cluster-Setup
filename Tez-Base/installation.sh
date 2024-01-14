#! /bin/bash

source ../cluster-env.sh
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/tez-site.xml
sudo cp ../Cluster-Configuration/tez-site.xml $HADOOP_CLUSTER_PATH
sudo cp ../Hadoop-Base/hadoop-init.sh $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
sudo wget https://downloads.apache.org/tez/0.9.2/apache-tez-0.9.2-bin.tar.gz
sudo tar -xvf apache-tez-0.9.2-bin.tar.gz
sudo ln -s apache-tez-0.9.2-bin tez
sudo rm apache-tez-0.9.2-bin.tar.gz
cd tez
sudo mv $HADOOP_CLUSTER_PATH/tez-site.xml  ./conf
sudo -S chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH
source ../hadoop-init.sh
hdfs dfs -mkdir -p /user/tez
hdfs dfs -mkdir -p /user/tez/logs
hdfs dfs -chmod g+w /user/tez
hdfs dfs -put * /user/tez