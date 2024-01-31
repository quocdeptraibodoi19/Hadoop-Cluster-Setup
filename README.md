# Hadoop-Cluster-Setup
This is the script to automatically setting up the Hadoop system based on 2 Docker containers:
- hadoop-master (Ubuntu Docker Base)
- hadoop-slave (Ubuntu Docker Base)

Since the system is deployed using Docker so originally we can not access to services provided by the ports in the Docker containers. Therefore, we have to exposed certain ports for the hadoop-master:
- 9870:9870 - NameNode interface
- 8001:8001 - ResourceManager Interface
- 8080:8080 - Tez Interface

Those are the ports that we will expose for hadoop-slave:
- 19888:19888 - MapReduce JobHistory Server Interface (showing logs)

For the Docker network, I create a new bridge docker network for the system: hadoop-net

## Guides:
1. Create a new bridge network in Docker:
```
    sudo docker network create hadoop-net
```
2. Create 2 docker containers:
```
    sudo docker run -dit --name hadoop-master --network hadoop-net -p 9870:9870 -p 8001:8001 -p 8080:8080 ubuntu:latest
```
```
    sudo docker run -dit --name hadoop-slave --network hadoop-net -p 19888:19888 ubuntu:latest
```
3. Set up Hive metastore:
```
    sudo docker run -dit --name mysql-metastore --network hadoop-net -e MYSQL_ROOT_PASSWORD=1234 -e MYSQL_USER=mysql-metastore -e MYSQL_PASSWORD=1234 -p 3306:3306 mysql:latest
```
```
    sudo docker exec -it mysql-metastore mysql -u root -p1234 -e "CREATE DATABASE metastore;"
```
```
    sudo docker exec -it mysql-metastore mysql -u root -p1234 -e "CREATE USER 'metastore'@'%' identified by '1234';"
```
```
    sudo docker exec -it mysql-metastore mysql -u root -p1234 -e "GRANT ALL PRIVILEGES ON metastore.* TO 'metastore'@'%';"
```
4. Set up Hadoop on 2 docker containers:
    1. Enter the 2 docker containers using ```sudo docker exec -it -u root [Container] bash```
    2. Install git using ``` apt-get -y update && apt-get -y install git sudo nano ```
    3. Clone this into each docker container: ``` git clone https://github.com/quocdeptraibodoi19/Hadoop-Cluster-Setup.git ```
    4. Enter the cloned project: ``` cd Hadoop-Cluster-Setup ```
    5. Setup the Hadoop environment: ``` source cluster-env.sh ```
    6. Run the init script: ``` source init.sh ```
    7. Distribute SSH keys in the Hadoop Cluster (master node): ``` source ssh_key_distribution.sh ```
    8. Enter Hadoop folder, and then install Hadoop (both nodes) ``` cd Hadoop-Base && source installation.sh```
    9. After installing, initiate the Hadoop Cluster (master node): ``` source hadoop-init.sh ```
    10. Enter Tez folder, and then install Tez (the same node as Hive): ``` cd Tez-Base && source installation.sh ```
    11. Enter Hive folder, and then install Hive (the same node as Tez) ``` cd Hive-Base && source installation.sh ```
    12. Enter Zookeeper folder, and then install (master node) ``` cd ZooKeeper-Base && source installation.sh ```
    13. Enter Presto folder, and then install(both nodes) ``` cd Presto-Base && source installation.sh ```