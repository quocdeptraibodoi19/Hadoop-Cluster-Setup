#! /bin/bash

source ../cluster-env.sh

while true; do
    echo "Please input the presto mode server (coordinator, or worker): "
    read presto_env
    if [ "$presto_env" == "coordinator" ] || [ "$presto_env" = "worker" ]; then
        break
    else
        echo "Invalid input. Please enter either 'coordinator' or 'worker'."
    fi
done

sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/coordinator_config.properties
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/coordinator_node.properties
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/hive.properties
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/jvm.config
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/log.properties
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/worker_config.properties
sudo -E python3 ../Cluster-Configuration/process-xml.py ../Cluster-Configuration/worker_node.properties

if [ "$presto_env" == "coordinator" ]; then
    sudo mv ../Cluster-Configuration/coordinator_config.properties ../Cluster-Configuration/config.properties
    sudo mv ../Cluster-Configuration/coordinator_node.properties ../Cluster-Configuration/node.properties

elif [ "$presto_env" = "worker" ]; then
    sudo mv ../Cluster-Configuration/worker_config.properties ../Cluster-Configuration/config.properties
    sudo mv ../Cluster-Configuration/worker_node.properties ../Cluster-Configuration/node.properties
fi

sudo cp ../Cluster-Configuration/hive.properties $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/log.properties $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/config.properties $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/node.properties $HADOOP_CLUSTER_PATH
sudo cp ../Cluster-Configuration/jvm.config $HADOOP_CLUSTER_PATH

cd $HADOOP_CLUSTER_PATH
sudo wget https://repo1.maven.org/maven2/com/facebook/presto/presto-server/0.285.1/presto-server-0.285.1.tar.gz
tar -xvf presto-server-0.285.1.tar.gz
ln -s presto-server-0.285.1 presto
sudo rm presto-server-0.285.1.tar.gz
sudo mkdir $PRESTO_DATA_DIR
cd presto
sudo mkdir -p etc/catalog
sudo mv -f $HADOOP_CLUSTER_PATH/hive.properties etc/catalog
sudo mv -f $HADOOP_CLUSTER_PATH/log.properties etc
sudo mv -f $HADOOP_CLUSTER_PATH/config.properties etc
sudo mv -f $HADOOP_CLUSTER_PATH/node.properties etc
sudo mv -f $HADOOP_CLUSTER_PATH/jvm.config etc

if [ "$presto_env" == "worker" ]; then
    sudo wget https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/0.285.1/presto-cli-0.285.1-executable.jar
    sudo tar -xvf presto-cli-0.285.1-executable.jar
    sudo mv presto-cli-0.285.1-executable presto
    sudo rm presto-cli-0.285.1-executable.jar
    sudo chmod +x presto
fi

sudo -S chown -R hadoop:hadoop $HADOOP_CLUSTER_PATH