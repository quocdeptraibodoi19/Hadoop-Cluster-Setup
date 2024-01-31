#!/bin/bash

export MASTER_NODE=hadoop-master
export SLAVE_NODE=hadoop-slave
export HIVE_METASTORE=mysql-metastore
export HIVE_METASTORE_DOCKER_NETWORK=hadoop-net
export HIVE_METASTORE_DB=metastore
export HIVE_METASTORE_USER=metastore
export HIVE_METASTORE_PASSWORD=1234
export HADDOP_SYS_INSTALLER=/Hadoop-Cluster-Setup

export HADOOP_CLUSTER_PATH=/usr/local/hadoop_cluster
export PRESTO_HOME=${HADOOP_CLUSTER_PATH}/presto
export PRESTO_DATA_DIR=${HADOOP_CLUSTER_PATH}/presto_data
export ZOOKEEPER_HOME=${HADOOP_CLUSTER_PATH}/zookeeper
export HBASE_HOME=${HADOOP_CLUSTER_PATH}/hbase
export SPARK_HOME=$HADOOP_CLUSTER_PATH/spark
export SPARK_CONF=$SPARK_HOME/conf
export TEZ_HOME=${HADOOP_CLUSTER_PATH}/tez
export TEZ_CONF_DIR=$TEZ_HOME/conf
export TEZ_JARS=$TEZ_HOME
export HIVE_HOME=${HADOOP_CLUSTER_PATH}/hive
export HIVE_CONF_DIR=$HIVE_HOME/conf
export HIVE_CONF=$HIVE_CONF_DIR
export HCAT_HOME=$HIVE_HOME/hcatalog
export HADOOP_HOME=${HADOOP_CLUSTER_PATH}/hadoop
export HADOOP_CONF=$HADOOP_HOME/etc/hadoop
export HADOOP_ROOT=$HADOOP_HOME
export HADOOP_BIN_PATH=$HADOOP_HOME/bin
export HADOOP_LIBEXEC_DIR=$HADOOP_HOME/libexec
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export PATH=$PATH:$ZOOKEEPER_HOME/bin:$HADOOP_HOME/sbin:$HADOOP_HOME/bin:$HIVE_HOME/bin:$HBASE_HOME/bin:$HCAT_HOME/bin:$SPARK_HOME/bin
export HADOOP_INSTALL=$HADOOP_HOME
export HBASE_CLASSPATH_PREFIX=$HIVE_HOME/lib
export HBASE_CLASSPATH=$HADOOP_CONF:$HADOOP_HOME/*:$HADOOP_HOME/lib/*:$ZOOKEEPER_HOME/*:$ZOOKEEPER_HOME/lib/*:$HIVE_HOME/*:$HIVE_HOME/lib/*
export HADOOP_CLASSPATH=$HADOOP_CLASSPATH:$HBASE_HOME/lib/
# For enabling hive to use the Tez engine
export HIVE_AUX_JARS_PATH="$TEZ_JARS"
export HADOOP_CLASSPATH=${TEZ_CONF_DIR}:${TEZ_JARS}/*:${TEZ_JARS}/lib/*

export HIVE_LIB=$HIVE_HOME/lib
CLASSPATH=${CLASSPATH}:${HIVE_LIB}/*.jar
for f in $HIVE_LIB/*.jar; do
    CLASSPATH=${CLASSPATH}:$f
done

# Add Spark JARs to the CLASSPATH
for f in $SPARK_HOME/jars/*.jar; do
    CLASSPATH=${CLASSPATH}:$f
done
