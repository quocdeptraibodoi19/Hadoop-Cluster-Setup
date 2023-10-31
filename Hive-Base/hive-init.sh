#! /bin/bash

source ../cluster-env.sh
hive --service hiveserver2 --hiveconf hive.server2.thrift.port=10000 \
    --hiveconf hive.server2.thrift.http.port=10001 \
    --hiveconf hive.root.logger=INFO,console
