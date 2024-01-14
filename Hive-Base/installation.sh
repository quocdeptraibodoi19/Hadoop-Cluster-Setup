#! /bin/bash

source ../cluster-env.sh
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/hive-site.xml
sudo -E cp ../Cluster-Configuration/hive-site.xml $HADOOP_CLUSTER_PATH
sudo -E cp ../Hadoop-Base/hadoop-init.sh $HADOOP_CLUSTER_PATH
cd $HADOOP_CLUSTER_PATH
sudo -E wget https://archive.apache.org/dist/hive/hive-2.3.7/apache-hive-2.3.7-bin.tar.gz
sudo -E tar -xvf apache-hive-2.3.7-bin.tar.gz
sudo -E ln -s apache-hive-2.3.7-bin hive
sudo -E rm apache-hive-2.3.7-bin.tar.gz
cd hive
sudo -E mv $HADOOP_CLUSTER_PATH/hive-site.xml  ./conf
sudo -E -Edo wget -P ./lib https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar
schematool -dbType mysql -initSchema
source ../hadoop-init.sh
hdfs dfsadmin -safemode leave
hdfs dfs -mkdir /user/
hdfs dfs -mkdir /user/hive
hdfs dfs -mkdir /user/hive/warehouse
hdfs dfs -mkdir /tmp
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse
