#! /bin/bash

source ../cluster-env.sh
python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/tez-site.xml
sudo cp ../Cluster-Configuration/tez-site.xml $HADOOP_CLUSTER_PATH
sudo cp ../Hadoop-Base/hadoop-init.sh $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
wget https://downloads.apache.org/tez/0.9.2/apache-tez-0.9.2-bin.tar.gz
sudo tar -xvf apache-tez-0.9.2-bin.tar.gz
sudo ln -s apache-tez-0.9.2-bin tez
sudo rm apache-tez-0.9.2-bin.tar.gz
cd tez
sudo mv $HADOOP_CLUSTER_PATH/tez-site.xml  ./conf
source ../hadoop-init.sh
hdfs dfs -mkdir /user/tez
hdfs dfs -mkdir /user/tez/logs
hdfs dfs -chmod g+w /user/tez
hdfs dfs -put * /user/tez