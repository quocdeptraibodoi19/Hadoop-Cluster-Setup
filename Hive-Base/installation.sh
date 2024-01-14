#! /bin/bash

source ../cluster-env.sh
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/hive-site.xml
sudo cp ../Cluster-Configuration/hive-site.xml $HADOOP_CLUSTER_PATH
sudo cp ../Hadoop-Base/hadoop-init.sh $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
sudo wget https://archive.apache.org/dist/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz
sudo tar -xvf apache-hive-2.3.7-bin.tar.gz
sudo ln -s apache-hive-2.3.7-bin hive
sudo rm apache-hive-2.3.7-bin.tar.gz
cd hive
sudo mv $HADOOP_CLUSTER_PATH/hive-site.xml  ./conf
sudo wget -P ./lib https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar
schematool -dbType mysql -initSchema
sudo -S chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH
source ../hadoop-init.sh
hdfs dfsadmin -safemode leave
hdfs dfs -mkdir -p /user/
hdfs dfs -mkdir -p /user/hive
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -mkdir -p /tmp
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse
