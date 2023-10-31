#! /bin/bash

source ../cluster-env.sh
docker run -dit --name ${HIVE_METASTORE} --network ${HIVE_METASTORE_DOCKER_NETWORK} -e MYSQL_ROOT_PASSWORD=1234 \
    -e MYSQL_USER=${HIVE_METASTORE_USER} -e MYSQL_PASSWORD=${HIVE_METASTORE_PASSWORD} -p 3306:3306 mysql:latest

sleep 20

docker exec -it ${HIVE_METASTORE} mysql -u root -p1234 -e "CREATE DATABASE ${HIVE_METASTORE_DB};"
docker exec -it ${HIVE_METASTORE} mysql -u root -p1234 -e \
    "GRANT ALL PRIVILEGES ON ${HIVE_METASTORE_DB}.* TO '${HIVE_METASTORE_USER}'@'%';"